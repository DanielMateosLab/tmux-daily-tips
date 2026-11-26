# Show a tmux window's pane count in its status bar with `#{window_panes}`

Format variables such as `#{window_panes}` expand to the number of panes in each window, so you can show a pane count in the status bar without running any command.

Add this to `~/.tmux.conf`:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Then reload with `tmux source-file ~/.tmux.conf`. Each window tab now reads something like `1:editor (3)`, which tells you at a glance how many splits a window holds.

The format string is evaluated per window, so every tab shows its own count. The `window-status-current-format` line keeps the active window's count visible too, and you can drop it if you only want the count on inactive windows.
