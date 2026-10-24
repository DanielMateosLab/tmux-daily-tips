# Keep a tmux Server Alive After Its Last Session Exits

By default, tmux shuts the server down as soon as the last session closes. The `exit-empty` server option controls this behavior. Turning it off keeps the server running with zero sessions, so new sessions attach faster and your server environment and global options survive.

## Command

```sh
tmux set -s exit-empty off
```

Use `-s` to set a server-wide option. Because the option is server-scoped, it applies to every session on that server.

## Why It Helps

- **Faster re-creation:** A running server skips the startup cost when you start a new session.
- **Persistent server environment:** Variables set with `set-environment -g` remain available to new sessions.
- **Stable global config:** Options and key bindings loaded with `source-file` stay in memory between sessions.

To make the setting permanent, add it to your `~/.tmux.conf`:

```tmux
set -s exit-empty off
```

## Example

Start with a fresh server and disable the auto-exit behavior:

```sh
tmux set -s exit-empty off
tmux new-session -d -s work
tmux kill-session -t work
tmux ls
```

The final `tmux ls` still reports that the server is running, even though it has no sessions. Confirm the option is set with:

```sh
tmux show -s exit-empty
```

To stop the server when you are finished, run:

```sh
tmux kill-server
```
