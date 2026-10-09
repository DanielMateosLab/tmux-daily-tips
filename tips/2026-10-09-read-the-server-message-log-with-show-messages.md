# Read the server message log with show-messages

When tmux reports an error you didn't see, `show-messages` replays the server's message log. It shows errors from config files, failed commands, and background jobs that flashed by in the status bar.

## The command

```
tmux show-messages
```

Add `-J` to include job output and `-T` to include terminal-related messages. Target a client with `-t` when several are attached.

## Explanation

tmux keeps a rolling log of messages it has shown, such as `unknown command`, `no current session`, or `source-file` errors. The status line only shows each message briefly, so a bad line in `.tmux.conf` can go unnoticed. `show-messages` prints the whole buffer so you can read it at your own pace.

The log holds up to `message-limit` entries, which defaults to 1000. Raise it if you want a longer history:

```
tmux set -g message-limit 5000
```

Running `show-messages` also works from a shell outside tmux, as long as the server is running.

## Example

Suppose a reload produces a status-bar flash you missed:

```
tmux source-file ~/.tmux.conf
```

Then check what went wrong:

```
tmux show-messages | tail -n 20
```

The output might include a line like this:

```
1 Tue Oct  6 09:14:02 2026: unknown command: set-optoin
```

Fix the typo in `~/.tmux.conf`, reload, and run `show-messages` again to confirm the error is gone. Pair it with `tmux clear-history` only if you want a fresh scrollback; the message log is separate and keeps its entries until the server restarts.
