# Show a tmux window's pane count in the status bar with `#{window_panes}`

The `window_panes` format variable holds the number of panes in each window. Put it in the status bar and you can see at a glance which windows have splits, without switching to them.

Format variables go in `status-right` or `window-status-format` using `#{variable}` syntax. tmux expands them on every status refresh, so the count stays current as you split and kill panes.

Add this to `~/.tmux.conf`:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload the config:

```
tmux source-file ~/.tmux.conf
```

Now each window tab shows its pane count in parentheses. A window named `editor` with three panes appears as `2:editor (3)`, while a single-pane window shows `1:shell (1)`.

To check the value without touching the config, run this from any pane:

```
tmux display-message -p '#{window_panes}'
```

This prints the pane count of the current window to the terminal.
