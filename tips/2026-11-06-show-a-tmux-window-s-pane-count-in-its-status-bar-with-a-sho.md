# Show a tmux window's pane count in its status bar with a short-circuit fallback

Tmux's `#{window_panes}` format variable reports how many panes a window contains. Combined with the `?:` conditional, you can show the count only when a window has more than one pane, so single-pane windows stay visually clean.

The format `#{?#{e|>:#{window_panes},1},[#{window_panes}],}` checks whether the pane count is greater than 1. If it is, the bracketed count appears; otherwise the expansion is empty.

Add this to your config to append the count to each window tab:

```tmux
set -g window-status-format "#I:#W#{?#{e|>:#{window_panes},1},[#{window_panes}],}"
set -g window-status-current-format "#I:#W#{?#{e|>:#{window_panes},1},[#{window_panes}],}"
```

Reload the configuration:

```sh
tmux source-file ~/.tmux.conf
```

Now a window with three panes shows `2:editor[3]` in the status bar, while a window with one pane shows just `1:shell`. You can check the value for any window directly:

```sh
tmux display-message -p -t :2 '#{window_panes}'
```

The `e|>:` operator is a numeric comparison supported since tmux 3.2. On older versions, use `#{?#{>:#{window_panes},1},...}` only if your build supports it, or fall back to checking `#{window_panes}` through a shell `if-shell` call.
