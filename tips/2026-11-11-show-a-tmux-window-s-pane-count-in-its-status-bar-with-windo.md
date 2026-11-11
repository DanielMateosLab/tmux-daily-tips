# Show a tmux window's pane count in its status bar with `#{window_panes}`

Tmux exposes the number of panes in a window as the format variable `#{window_panes}`. You can drop it into the status bar, so you always see how many splits a window holds without running `list-panes`.

Add this to your config:

```tmux
set -g status-right "#{?window_panes,#{window_panes} panes,} | %H:%M"
```

Reload with `prefix` + `:` then `source-file ~/.tmux.conf`, or run it straight from the command prompt:

```tmux
tmux set -g status-right "#{window_panes} panes | %H:%M"
```

The `#{window_panes}` variable expands for the active window only when used in `status-right`. To show the count for every window in the window list, put it in `window-status-format`:

```tmux
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Split a window with `prefix` + `%` and the count in the status bar updates on the next refresh. Pick the `status-right` form for a single summary and the window-status form when you compare several windows at once.
