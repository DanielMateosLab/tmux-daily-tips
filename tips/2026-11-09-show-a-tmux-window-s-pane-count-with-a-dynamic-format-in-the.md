# Show a tmux window's pane count with a dynamic format in the status bar

Use `#{window_panes}` in `status-right` to show how many panes the current window contains. It updates on every split or kill, so you can spot a crowded window without switching to it.

## Option

```
set -g status-right "#{?window_panes,#{window_panes} panes,} | %H:%M"
```

## Example

Add this to `~/.tmux.conf`:

```
set -g status-right "#{?window_panes,#{window_panes} panes,} | %H:%M"
```

Reload with `tmux source-file ~/.tmux.conf`. The status bar now reads `3 panes | 14:22` for a window with three panes. The `#{?window_panes,...,}` conditional hides the label when the value is empty, which keeps the bar clean during rare edge cases.

## Why it works

`window_panes` is a format variable that holds the number of panes in the current window. Tmux expands it on each status refresh, so the count stays accurate after any layout change.
