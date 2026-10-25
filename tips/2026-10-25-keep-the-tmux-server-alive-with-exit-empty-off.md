# Keep the tmux Server Alive with `exit-empty off`

By default, the tmux server exits as soon as its last session closes. Setting `exit-empty` to `off` keeps the server running with no sessions, so new sessions start instantly and your server-level options and key bindings survive.

## Command

```tmux
set -g exit-empty off
```

Set it in `~/.tmux.conf` to make it permanent, or run it from a live session with `tmux set -g exit-empty off`. It is a server option, so `-g` is the right scope.

## Explanation

When `exit-empty` is `on` (the default), tmux shuts down the server once no sessions remain. That is fine for most workflows, but it has side effects:

- Any `set -s` server options, global hooks, and `-g` key bindings you rely on are lost and must be re-sourced.
- Scripts that start a server and then create a session can race against the server exiting.
- Starting tmux again takes a moment because the server process has to be relaunched.

With `exit-empty off`, the server stays up in the background. You can kill every session and still create a new one without reloading your configuration.

To check the current value, run:

```tmux
show -s exit-empty
```

To shut the server down explicitly when you are finished, use `kill-server`.

## Example

Add this to `~/.tmux.conf`:

```tmux
# Keep the server running after the last session exits
set -s exit-empty off
```

Then clean up all sessions and confirm the server is still running:

```sh
tmux kill-session -a
tmux ls            # reports "no server running" only if the server is gone
tmux new-session -d -s scratch
tmux ls            # the new session starts immediately, without reloading config
```

Because the server keeps its configuration, `tmux new-session` returns immediately with your key bindings and options already in place.
