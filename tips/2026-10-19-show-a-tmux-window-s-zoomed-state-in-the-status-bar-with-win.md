# Show a tmux window's zoomed state in the status bar with `#{window_zoomed_flag}`

tmux tracks whether a window has a zoomed pane in the format variable `window_zoomed_flag`. It expands to `1` when a pane in the window is zoomed and `0` otherwise. Pair it with `window_flags` in the status line to see at a glance which windows are zoomed, without checking each one.

## The format variable

`#{window_zoomed_flag}` is available anywhere tmux expands formats: `status-format`, `window-status-format`, `display-message`, and `list-windows -F`. Because it is a plain `0` or `1`, use it with `#{?...}` to print a marker only when it matters.

## Show a marker in the window list

Add a conditional to `window-status-format` so zoomed windows get a `Z` next to their name:

```tmux
set -g window-status-format " #I:#W#{?window_zoomed_flag,Z,} "
set -g window-status-current-format " #I:#W#{?window_zoomed_flag,Z,} "
```

Windows that are not zoomed show no marker. A zoomed window shows `1:editor Z`, which is easy to miss when you zoom in and forget.

## Check the flag from the command line

To query one window without changing the status bar, use `display-message` with `-p`:

```sh
tmux display-message -p -t mysession:2 '#{window_zoomed_flag}'
```

This prints `1` if window 2 has a zoomed pane and `0` if not. It is useful in scripts that need to skip zoomed windows before a layout change.

## Reload the configuration

Apply the change without restarting tmux:

```sh
tmux source-file ~/.tmux.conf
```
