# Show a tmux window's zoomed state alongside its name with `window_zoomed_flag`

tmux exposes a format variable, `#{window_zoomed_flag}`, that expands to `1` when the window has a zoomed pane and an empty string otherwise. Adding it to `window-status-format` marks zoomed windows in the status bar, so you can spot a zoomed window before you switch to it.

## Setup

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format " #I:#W#{?window_zoomed_flag, [Z],} "
set -g window-status-current-format " #I:#W#{?window_zoomed_flag, [Z],} "
```

The conditional `#{?window_zoomed_flag, [Z],}` prints ` [Z]` only when the flag is set. Both the inactive and the current window formats need it, otherwise the marker disappears on the active tab.

## Checking a window from the command line

You can read the flag directly without the status bar:

```sh
tmux display-message -p -t mywork:2 '#{window_zoomed_flag}'
```

This prints `1` if window 2 of session `mywork` is zoomed, and a blank line otherwise. Scripts can use this to decide whether to unzoom before sending keys.

## Reloading

Apply the change without restarting:

```sh
tmux source-file ~/.tmux.conf
```

Zoom any pane with `prefix z`. The window's tab in the status bar now shows ` [Z]` until you unzoom it.
