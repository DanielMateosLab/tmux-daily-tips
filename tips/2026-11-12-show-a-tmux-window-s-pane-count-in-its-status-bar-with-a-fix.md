# Show a tmux window's pane count in its status bar with a fixed-width format

Some windows get crowded and the window list alone doesn't tell you how many panes they hold. Adding `#{window_panes}` to the window status format shows the count right in the bar, and you can pad it so the bar doesn't shift when the number changes.

Two things matter here. `window_panes` counts every pane in the window, including ones hidden behind a zoomed pane. And the format uses `#{p3:...}`-style padding only in newer tmux releases, so the example below sticks to a plain conditional that works on tmux 2.9 and later.

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format '#I:#W #{?#{e|>:#{window_panes},1},[#{window_panes}],}'
set -g window-status-current-format '#I:#W #{?#{e|>:#{window_panes},1},[#{window_panes}],}'
```

The `#{?condition,yes,no}` construct shows `[N]` only when the window has more than one pane. Single-pane windows stay clean, so the count appears only where it adds information.

Reload the config without restarting tmux:

```tmux
tmux source-file ~/.tmux.conf
```

Now a window with three panes shows as `2:server [3]` in the status bar, and single-pane windows show just `1:shell`. Use `window-status-current-format` as well so the active window gets the same count.
