# Show a tmux window's pane count in its status bar with `#{window_panes}`

tmux exposes the number of panes in each window as the format variable `#{window_panes}`. Put it in `window-status-format` to see at a glance which windows are split and how many panes each holds, without opening the window.

The existing tips already cover pane counts in the window name, tab style, and status text in several forms, so this one focuses on the per-window status list itself, using the `#I` index and `#W` name alongside the count.

Run this from a shell inside tmux:

```sh
tmux set -g window-status-format '#I:#W (#{window_panes})'
tmux set -g window-status-current-format '#[bold]#I:#W (#{window_panes})#[nobold]'
```

The first line sets the format for inactive windows. The second sets the format for the active window and adds `#[bold]` so the current window stands out. Both lines take effect immediately because `set -g` writes to the global session options.

To make the change permanent, add the same two lines to `~/.tmux.conf` and reload with `tmux source-file ~/.tmux.conf`.

For example, if you have a window named `editor` with three panes at index 2, the status bar shows `2:editor (3)`. A single-pane window shows `1:shell (1)`. Because the count updates every time tmux redraws the status line, it stays accurate after you split or join panes, so you never need to check manually.
