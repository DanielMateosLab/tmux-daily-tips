# Show a tmux window's zoom state in the status bar with `#{window_zoomed_flag}`

Tmux exposes a format variable that tells you whether the active pane is zoomed. Pair it with a conditional format to flag zoomed windows in the status bar, so you never forget a pane is hidden behind a full-screen view.

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format '#I:#W#{?window_zoomed_flag, [Z],}'
set -g window-status-current-format '#I:#W#{?window_zoomed_flag, [Z],}'
```

The `#{?window_zoomed_flag, [Z],}` expression is a conditional. If the flag is set, tmux prints ` [Z]`; otherwise it prints nothing. Both the normal and current-window formats need it, or only the active window shows the marker.

Reload the config:

```sh
tmux source-file ~/.tmux.conf
```

Now zoom a pane with `prefix z`. The window's entry in the status bar gains a `[Z]` suffix, and removing the zoom drops it. Check the value of the flag for any window with:

```sh
tmux display-message -p -t :1 '#{window_zoomed_flag}'
```

It prints `1` when window 1 is zoomed and `0` when it is not.
