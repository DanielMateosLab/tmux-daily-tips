# Show a tmux window's pane count in the status bar with `#{window_panes}`

Format variables let the status bar show live window data without any script. The `#{window_panes}` variable expands to the number of panes in each window, so you can see at a glance which windows hold splits.

The variable works in `status-format` and `window-status-format`. Put it next to the window name and tmux redraws the count whenever a pane opens or closes.

## Example

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

Each window tab now reads something like `1:editor (3)`, which means three panes. Split or join a pane and the number updates on the next status refresh.

To check the value before editing your config, run this from any pane:

```tmux
tmux display-message -p '#{window_panes}'
```
