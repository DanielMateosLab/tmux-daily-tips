# Show a tmux window's pane count in its tab title with `window-status-format`

Add `#{window_panes}` to the window status format so every window in the status bar shows how many panes it contains.

Set it in `~/.tmux.conf`:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

`window-status-format` controls how inactive windows appear in the status bar, and `window-status-current-format` controls the active window. Both expand `#{window_panes}` to the number of panes in that window, so a three-pane window shows `(3)` next to its name.

Reload the config with `tmux source-file ~/.tmux.conf`. The counts update as you split and kill panes, with no extra keys to press.

Example: after running `prefix %` twice in window 1, the status bar shows `1:shell (3)` for that window while other windows keep their own counts.
