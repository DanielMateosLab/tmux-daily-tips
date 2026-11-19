# Show a tmux window's pane count in its status bar with a dynamic format

Several existing tips already show the pane count with `#{window_panes}`, so this one takes a different route: `#{?}` conditionals plus `#{e|}` arithmetic. Together they can show the count only when a window actually has more than one pane, which keeps single-pane windows clean.

## Syntax

```
set -g window-status-format '#{window_index}:#{window_name}#{?#{e|>:#{window_panes},1},[#{window_panes}],}'
set -g window-status-current-format '#{window_index}:#{window_name}#{?#{e|>:#{window_panes},1},[#{window_panes}],}'
```

`#{e|>:A,B}` returns `1` when `A` is greater than `B`, and `#{?cond,yes,no}` picks a branch based on that result. The `no` branch is empty, so single-pane windows show no suffix at all.

## Explanation

The `e|` prefix turns on numeric evaluation inside a format. Without it, `#{?}` treats any non-empty string as true, so `1` and `0` would both look truthy. The comparison operators available are `e|==`, `e|!=`, `e|<`, `e|<=`, `e|>`, `e|>=`, plus `e|+`, `e|-`, `e|*`, and `e|/` for arithmetic.

Put the same expression in both `window-status-format` and `window-status-current-format` so the active window follows the same rule as the others. Then reload with `source-file ~/.tmux.conf`.

## Example

Add the two lines to `~/.tmux.conf`, then run:

```
tmux source-file ~/.tmux.conf
```

A window named `editor` with three panes now appears in the status bar as `2:editor[3]`, while a window named `shell` with one pane appears as `1:shell`. Split a pane in `editor` and the count updates on the next status refresh.
