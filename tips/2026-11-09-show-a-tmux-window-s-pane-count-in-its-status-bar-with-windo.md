# Show a tmux window's pane count in its status bar with `#{window_panes}`

Tmux exposes the number of panes in each window as the format variable `#{window_panes}`. Put it in `window-status-format` to see at a glance which windows are split, without switching to them.

Add this to your config:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload with `prefix + r` if you bound it, or run `tmux source-file ~/.tmux.conf`. Each window tab now shows its pane count next to its name. A single-pane window reads `(1)`, and a window split into three reads `(3)`.

To show the count only when a window is split, wrap it in a conditional so single-pane windows stay clean:

```
set -g window-status-format " #I:#W#{?#{/=:#{window_panes},1},, [#{window_panes}]} "
set -g window-status-current-format " #I:#W#{?#{/=:#{window_panes},1},, [#{window_panes}]} "
```

The `#{?condition,then,else}` form checks whether the pane count is greater than one. Windows with one pane show only their index and name, and split windows add ` [2]`, ` [3]`, and so on.
