# Show a tmux window's pane count in the status bar with `#{window_panes}`

The `window_panes` format variable holds the number of panes in each window. Adding it to `window-status-format` shows split density at a glance, so you know which windows hold a layout before you switch to them.

Set it in your config:

```tmux
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload the config with `prefix` + `:` then `source-file ~/.tmux.conf`, or run `tmux source-file ~/.tmux.conf` from a shell.

Each window now shows its pane count in parentheses. Splitting a window with `prefix` + `%` bumps the count from `(1)` to `(2)` on the next status redraw, and killing a pane drops it again.

To see the same value from a script without touching the status bar, query it directly:

```sh
tmux display-message -p -t mysession:2 '#{window_panes}'
```

This prints the pane count for window 2 of `mysession` and exits, which works well in scripts that decide whether a window needs cleanup.
