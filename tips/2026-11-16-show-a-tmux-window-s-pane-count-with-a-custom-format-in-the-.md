# Show a tmux window's pane count with a custom format in the status bar

Use `#{window_panes}` inside `window-status-format` to show how many panes each window contains, right next to its name.

```
set -g window-status-format ' #I:#W [#{window_panes}] '
set -g window-status-current-format ' #I:#W [#{window_panes}] '
```

Reload with `prefix` + `:` then `source-file ~/.tmux.conf`, or run `tmux source-file ~/.tmux.conf` from a shell.

## Example

Suppose window 1 has three panes and window 2 has one. The status bar shows:

```
1:editor [3]  2:logs [1]
```

Set both `window-status-format` and `window-status-current-format` so the count appears on the active window too. Otherwise the current window shows no count, which makes the bar inconsistent.

To count panes only in the current window's status entry, keep the same format and add a `#{?window_zoomed_flag,Z,}` marker if you also want to see zoom state at a glance.
