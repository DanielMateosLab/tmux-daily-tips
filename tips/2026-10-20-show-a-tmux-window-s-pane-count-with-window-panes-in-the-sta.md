# Show a tmux window's pane count with `#{window_panes}` in the status bar

Uptrace-style dashboards aside, the quickest way to see how crowded a window is comes from a format variable, not a command. Put `#{window_panes}` in `status-right` and the status bar shows the pane count of the current window, updating as you split and kill.

Add this to `~/.tmux.conf`:

```
set -g status-right '#{?window_zoomed_flag,[Z] ,}panes: #{window_panes} | %H:%M'
```

Reload with `prefix` + `:` then `source-file ~/.tmux.conf`, or run `tmux source-file ~/.tmux.conf` from the shell.

Format variables expand per window, so you can also show the count in every window tab. Set `window-status-format` to include it:

```
set -g window-status-format ' #I:#W (#{window_panes}) '
set -g window-status-current-format ' #I:#W (#{window_panes}) '
```

Now each tab reads something like `2:editor (3)`, and the current window's count is visible without `prefix` + `q`, which flashes pane numbers and disappears after a second.

To check the value before you commit it to the config, run this from any pane:

```
tmux display-message -p '#{window_panes}'
```

The `-p` flag prints the expanded value to stdout instead of the status line, so you can confirm the variable resolves before you wire it into the status bar.
