# Show a tmux window's pane count in its status bar with a custom format

Use `#{window_panes}` inside `status-right` or `window-status-format` to show how many panes each window contains. The count updates on every status refresh, so you can see at a glance which windows are split and which are single-pane.

## Setup

Add this to `~/.tmux.conf` to append the pane count to every window's entry in the status bar:

```tmux
set -g window-status-format '#I:#W [#{window_panes}]'
set -g window-status-current-format '#[bold]#I:#W [#{window_panes}]#[nobold]'
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

## Checking the count from the command line

To print the pane count for the current window without touching the status bar, run:

```tmux
tmux display-message -p '#{window_panes}'
```

To list the count for every window in a session, use `list-windows` with a format:

```tmux
tmux list-windows -F '#{window_index}: #{window_name} has #{window_panes} pane(s)'
```

## Example output

With three windows, the status bar might read:

```
[0:shell [1]] 1:editor [3] 2:logs [2]
```

Window `0` is a single shell pane, window `1` has three panes, and window `2` has two. Because the format is a plain string, you can wrap the count in any text you like, such as `{3 panes}` or `*3*`, without changing any other behavior.
