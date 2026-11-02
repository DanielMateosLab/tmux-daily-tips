# Show a tmux window's last-bell time with `display-message`

The `window_bell_flag` format only tells you whether a bell has fired. For how long ago the window last rang, you can use `#{window_activity}` together with `#{t:...}` for a readable timestamp. Pair it with `display-message -p` to read it from the shell without touching the status bar.

## Command

```sh
tmux display-message -p -t <window> '#{t:window_activity}'
```

`window_activity` holds the Unix time of the last output in that window, and `t:` turns it into a human-readable date. Because `-p` prints to stdout, you can call it from a script and capture the result.

## Explanation

`window_activity` updates whenever a pane in the window produces output, not only on bells. That makes it a general "last touched" signal. Combined with `-p`, the value goes to stdout instead of the status line, so scripts can read it directly. Use `-t` to target any window by index or name.

## Example

Check when the window named `build` last produced output:

```sh
tmux display-message -p -t build '#{t:window_activity}'
```

Compare it against the current time in a script to find idle windows:

```sh
last=$(tmux display-message -p -t build '#{window_activity}')
now=$(date +%s)
echo "build idle for $((now - last)) seconds"
```

Run this from any shell inside tmux, or from outside with `tmux -L <socket>` if you use a named server.
