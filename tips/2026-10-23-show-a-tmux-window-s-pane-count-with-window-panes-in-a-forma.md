# Show a tmux window's pane count with `#{window_panes}` in a format string

The latest tip covers `window_panes` in status bar and name formats, so this one covers a different use: a one-off value you can read from a shell script or a bind-key prompt without changing any config.

Run `display-message -p` with the format variable `#{window_panes}` to print how many panes the current window holds:

```sh
tmux display-message -p '#{window_panes}'
```

The `-p` flag prints the expanded format to stdout instead of the status line, so the value lands in your shell. Pass a target with `-t` to read another window without switching to it:

```sh
tmux display-message -p -t mysession:2 '#{window_panes}'
```

This works well in scripts that decide whether a split is needed:

```sh
if [ "$(tmux display-message -p '#{window_panes}')" -lt 3 ]; then
  tmux split-window -h
fi
```

For a quick check without a shell, bind a key to show the count on the status line:

```tmux
bind P display-message "Panes: #{window_panes}"
```

Press `prefix` then `P` and the status line shows the pane count for the window you are in. The format string expands at the moment you press the key, so the number reflects the current state.
