# Show a tmux window's pane count in its status bar with `#{window_panes}`

The `window_panes` format variable holds the number of panes in each window, and you can drop it straight into `window-status-format` so every tab shows its size without a script.

## Why it helps

When you split a window into several panes, the window name alone does not tell you how crowded it is. Adding the count to the status bar lets you spot a window with five panes from across the room, and it updates on every split or kill with no extra commands.

## Setting it up

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

## Example

With a window named `editor` that has three panes, the tab reads:

```
 2:editor (3)
```

Split it again with `prefix %` and the tab becomes `2:editor (4)` on the next redraw. Use `window-status-current-format` as well so the active window shows the same count.

## Checking the value

To see the number for the current window without changing the status bar, run:

```tmux
tmux display-message -p '#{window_panes}'
```
