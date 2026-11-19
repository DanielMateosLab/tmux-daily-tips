# Show a tmux window's pane count in its status bar with `#{window_panes}`

The `window_panes` format variable holds the number of panes in a window, and you can drop it straight into `status-right` so the count stays visible without running any command.

Add this line to `~/.tmux.conf`:

```
set -g status-right "#{window_panes} panes | %H:%M"
```

That shows the pane count of the *current* window. To see the count for every window next to its name, use `window-status-format` instead:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload the config with `prefix` + `:` then `source-file ~/.tmux.conf`, or run:

```
tmux source-file ~/.tmux.conf
```

Split the window and watch the number change:

```
tmux split-window -h
```

The status bar now reads `1:bash (2)` for that window, and it updates as soon as you add or close a pane. Zoomed windows still report their real pane count, so the number never hides panes behind a zoom.
