# Show a tmux window's pane count in its status bar with a conditional format

Use `#{?condition,yes,no}` in `status-right` to show a window's pane count only when the window actually has more than one pane. Single-pane windows stay clean, and split windows get a visible `[3p]` marker.

tmux format strings support conditionals with `#{?cond,true,false}`. The condition is any format variable that evaluates to a non-zero number or non-empty string. Combine that with `#{window_panes}` to display the count only when it matters.

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format '#I:#W#{?#{>:#{window_panes},1},[#{window_panes}p],}'
set -g window-status-current-format '#I:#W#{?#{>:#{window_panes},1},[#{window_panes}p],}'
```

The `#{>:a,b}` comparison returns `1` when `a` is greater than `b`. So `#{?#{>:#{window_panes},1},[#{window_panes}p],}` expands to `[2p]` for a two-pane window and to nothing for a single-pane window.

Reload the configuration without restarting:

```sh
tmux source-file ~/.tmux.conf
```

Example result in the status bar:

```
1:shell 2:editor[3p] 3:logs
```

Window `2` has three panes and shows `[3p]`. Windows `1` and `3` have one pane each and show no suffix, so you can spot split windows at a glance.
