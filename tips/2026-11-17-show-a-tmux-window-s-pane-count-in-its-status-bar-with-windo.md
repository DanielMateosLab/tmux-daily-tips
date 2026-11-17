# Show a tmux window's pane count in its status bar with window_panes

The `#{window_panes}` format variable holds how many panes a window contains. Put it in `status-right` (or any status format) to see at a glance whether a background window is split.

Set it in your config:

```
set -g status-right "#{window_panes} panes | %H:%M"
```

Or add it per window with `set-window-option` so only the windows you care about show it:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

To check the value right now without editing your config, run:

```
tmux display-message -p '#{window_panes}'
```

Reload with `prefix` then `:` and `source-file ~/.tmux.conf`. The count updates on every status refresh, so a split you make in another window shows up within a second or two.
