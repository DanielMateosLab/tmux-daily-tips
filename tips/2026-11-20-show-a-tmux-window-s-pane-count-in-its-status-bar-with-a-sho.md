# Show a tmux window's pane count in its status bar with a short format alias

Tmux exposes the number of panes in a window as the format variable `#{window_panes}`. Pair it with a `#{?...}` conditional to show a count only when a window has more than one pane, which keeps single-pane windows clean in the status bar.

Add this to `~/.tmux.conf`:

```
set -g window-status-format "#I:#W#{?#{>:#{window_panes},1},[#{window_panes}],}"
set -g window-status-current-format "#I:#W#{?#{>:#{window_panes},1},[#{window_panes}],}"
```

Reload the config with `tmux source-file ~/.tmux.conf`, or press `prefix` then `:` and run the same command.

The `#{>:a,b}` comparison returns `1` when `a` is greater than `b`, so the `#{?cond,yes,no}` conditional adds `[N]` only for windows with two or more panes. A window with one pane shows just `1:shell`, while a window split three ways shows `2:editor[3]`.

To check the value for the current window before editing, run:

```
tmux display-message -p '#{window_panes}'
```
