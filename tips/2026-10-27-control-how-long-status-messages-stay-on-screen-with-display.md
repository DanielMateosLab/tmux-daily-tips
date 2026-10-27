# Control how long status messages stay on screen with display-message -d

`display-message -d <ms>` sets how long a status-bar message stays visible. Without `-d`, the message uses the `display-time` option (default 750 ms), which is easy to miss when the message carries useful output.

## Syntax

```
tmux display-message -d <milliseconds> "<message>"
```

Setting `-d 0` keeps the message on screen until you press a key.

## Explanation

- `-d` overrides `display-time` for a single message only.
- Useful inside scripts or key bindings where a result needs to be read before it disappears.
- To change the default for every message, set the server-wide option instead:

```
tmux set -g display-time 3000
```

## Example

Bind a key that shows the current session's window count for 5 seconds:

```
tmux bind-key W display-message -d 5000 "Windows: #{session_windows} in #{session_name}"
```

Press `prefix` then `W`. The message stays in the status bar for five seconds, long enough to read it.

For a message that stays until dismissed, use `-d 0` in a script that reports a result you need to copy:

```
tmux display-message -d 0 "Build finished: $(tail -1 build.log)"
```
