# Show a tmux window's pane count in its status bar with a custom format

The `window_panes` format variable holds the number of panes in each window, so you can show it next to every window name in the status bar without touching the layout.

## Command

```
tmux set -g window-status-format ' #I:#W (#{window_panes}) '
tmux set -g window-status-current-format ' #I:#W (#{window_panes}) '
```

## Explanation

`window-status-format` controls how each inactive window appears in the status line, and `window-status-current-format` controls the active one. Both accept format strings, so `#{window_panes}` expands to the pane count of that specific window at render time. Setting both keeps the count visible whether or not the window is focused.

Add the lines to `~/.tmux.conf` and run `tmux source-file ~/.tmux.conf` to apply them to the running server. The `#I` and `#W` placeholders keep the window index and name, so the default look stays familiar.

## Example

With three windows, the status bar might read:

```
 1:editor (2)   2:logs (1)  [3:shell (4)]
```

Here window 3 is active, shown in brackets by the default current-window style, and it has four panes. Splitting or killing a pane updates the number on the next status refresh, with no extra scripting.
