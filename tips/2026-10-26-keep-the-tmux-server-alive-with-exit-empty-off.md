# Keep the tmux server alive with `exit-empty off`

By default, the tmux server exits as soon as its last session closes. Setting `exit-empty` to `off` keeps the server running with zero sessions, so you can start new sessions quickly without paying the server startup cost again.

Note that `exit-empty` is a server option, so it must be set with `-s`.

## Command

```sh
tmux set -s exit-empty off
```

## Explanation

- `exit-empty` controls whether the server exits when no sessions remain. The default is `on`.
- With `off`, the server stays alive in the background even after every session is killed or detached-and-exited.
- This is useful when you rely on tmux-aware tools or scripts that expect a running server, and when you want `tmux new -d` to be near-instant.
- Set it in your config file so it applies every time the server starts:

```tmux
# ~/.tmux.conf
set -s exit-empty off
```

- To check the current value, run `tmux show -s exit-empty`.

## Example

Start the server with no sessions, then confirm it is still running:

```sh
tmux set -s exit-empty off
tmux kill-session -a        # or exit every shell in every session
tmux ls                     # reports "no server running" only if the server exited
```

Because the server is still up, a new session appears immediately:

```sh
tmux new -d -s scratch
tmux send-keys -t scratch 'echo ready' Enter
```

Stop the server explicitly when you are done with `tmux kill-server`.
