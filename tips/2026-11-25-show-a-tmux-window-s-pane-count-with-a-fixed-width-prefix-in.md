# Show a tmux window's pane count with a fixed-width prefix in the status bar

Use `#{window_panes}` in a format string to print how many panes a window holds. Pair it with `#{?...}` or a literal prefix so the number is readable at a glance in the window list.

## Why it helps

The default window list shows only the window index and name. When a window has several panes, nothing in the list tells you that until you switch to it. Adding the count to `window-status-format` lets you spot a crowded window from anywhere in the session.

## Setting it up

Add this to `~/.tmux.conf`:

```
set -g window-status-format " #I:#W [#{window_panes}] "
set -g window-status-current-format " #I:#W [#{window_panes}] "
```

Both lines matter. `window-status-format` styles inactive windows, and `window-status-current-format` styles the active one. Changing only one leaves the other window without a count.

Reload the config without restarting:

```
tmux source-file ~/.tmux.conf
```

## Checking the value directly

You can confirm the number tmux will print before editing the config:

```
tmux display-message -p '#{window_panes}'
```

This prints the pane count of the current window to the shell. Run it in any pane to verify the format variable resolves to the number you expect.

## Example

Start with three panes in window 1 and one pane in window 2:

```
tmux split-window -h
tmux split-window -v
tmux new-window
```

After sourcing the config, the status bar shows `1:bash [3]` on the first window and `2:bash [1]` on the second. The count updates as you split or kill panes, because tmux re-evaluates the format on every status refresh.
