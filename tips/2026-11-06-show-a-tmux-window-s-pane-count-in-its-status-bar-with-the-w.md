# Show a tmux window's pane count in its status bar with the `#{window_panes}` format

The `window_panes` format variable holds the number of panes in each window. Put it in `window-status-format` and every window tab shows how many splits it contains, so you can spot a crowded window without switching to it.

Add this to `~/.tmux.conf`:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload the config with `prefix` + `:` and then `source-file ~/.tmux.conf`, or run `tmux source-file ~/.tmux.conf` from a shell.

Each tab now reads like `2:editor (3)`, meaning window 2 is named `editor` and has three panes. The count updates as you split or join panes, because tmux re-evaluates the format on every status refresh.

To check the value for one window without touching the status bar, run:

```
tmux display-message -p -t :2 '#{window_panes}'
```

This prints `3` for the example above. Use `-t` with a window index, name, or `session:index` target to query any window.
