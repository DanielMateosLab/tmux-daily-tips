# Show a tmux window's pane count with `window_panes` in the window list

Set `window-status-format` to include `#{window_panes}` so each window in the status bar shows how many panes it holds. You can see at a glance which windows are split and which are single-pane, without switching to them.

## Configuration

Add this to `~/.tmux.conf`:

```
set -g window-status-format '#I:#W (#{window_panes})'
set -g window-status-current-format '#[bold]#I:#W (#{window_panes})#[nobold]'
```

Reload the config:

```
tmux source-file ~/.tmux.conf
```

## Why it helps

`#{window_panes}` expands to the number of panes in each window. Putting it in the inactive and current window formats keeps the count visible for every window, not just the active one. Splitting a window or closing a pane updates the count on the next status refresh.

## Example

Suppose a session has three windows:

- `0`: a single editor pane
- `1`: a server pane split into logs and shell
- `2`: a build window with four panes

The status bar then reads:

```
0:vim (1)  1:server (2)  2:build (4)
```

The number in parentheses tells you the layout before you select the window. Use `prefix + w` if you also want the full tree view.
