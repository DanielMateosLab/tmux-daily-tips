# Keep the tmux Server Alive After the Last Session Exits

By default, the tmux server shuts down as soon as its last session closes. The `exit-empty` server option controls this. Turning it off keeps the server running with no sessions, so later `new-session` calls are fast and your server-level settings and hooks stay loaded.

## The Command

```sh
tmux set -s exit-empty off
```

`-s` sets a server option. Add it to your config to make it permanent:

```tmux
# ~/.tmux.conf
set -s exit-empty off
```

Reload with `tmux source-file ~/.tmux.conf`, or see [[source-file-reload-config]] for the workflow.

## How It Works

- `exit-empty on` (default): the server exits when no sessions remain.
- `exit-empty off`: the server stays up, and `tmux ls` reports no sessions instead of "no server running."

This matters when you rely on server-wide state, such as global hooks set with `set-hook -g`, `set -s` options, or `run-shell` jobs that should survive between sessions.

## Example

Start with the setting on and a single session:

```sh
tmux new-session -d -s scratch
tmux kill-session -t scratch
tmux ls            # "no server running" -- the server has exited
```

Now with the setting off:

```sh
tmux set -s exit-empty off
tmux new-session -d -s scratch
tmux kill-session -t scratch
tmux ls            # reports no sessions, but the server is still up
pgrep -l tmux      # the tmux server process is still listed
```

To shut the server down explicitly, use `tmux kill-server`. This also stops any server-side jobs and hooks.

## Related Option

`exit-unattached` is the session-level counterpart. When set to `on`, a session exits as soon as no client is attached to it. Use it when you want sessions to clean up after you detach:

```tmux
set -g exit-unattached on
```

Use `exit-empty off` to keep the server, and `exit-unattached on` to clean up idle sessions. Combining them gives you a long-lived server that doesn't accumulate detached sessions.
