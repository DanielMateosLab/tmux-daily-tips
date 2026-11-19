# Show a tmux window's pane count in its status bar with `window_panes`

Add `#{window_panes}` to `window-status-format` to see how many panes each window holds, right in the status line. Useful when you have several windows and want to spot the dense ones at a glance.

Add this to `~/.tmux.conf`:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload with `tmux source-file ~/.tmux.conf`, or press `prefix` then `:` and run `source-file ~/.tmux.conf`.

Each window tab now reads something like `1:editor (3)`, meaning window 1 is named `editor` and holds three panes. Splitting or closing a pane updates the count the next time the status bar redraws.

To check the value without touching the config, run:

```
tmux display-message -p '#{window_panes}'
```

This prints the pane count for the current window.
