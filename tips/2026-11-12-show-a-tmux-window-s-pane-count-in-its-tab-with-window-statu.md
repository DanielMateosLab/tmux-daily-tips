# Show a tmux window's pane count in its tab with `window-status-format`

Run `tmux set -g window-status-format " #I:#W (#{window_panes}) "` to append each window's pane count to its entry in the status bar, and `window-status-current-format` does the same for the active window.

Tmux expands `#{window_panes}` for every window in the status line, so you can see at a glance which windows hold splits without switching to them. Setting both formats keeps the active window readable against the rest.

Example:

```tmux
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #[bold]#I:#W (#{window_panes})#[nobold] "
```

Reload the config with `tmux source-file ~/.tmux.conf` and each tab shows its pane count, such as `2:logs (3)`.
