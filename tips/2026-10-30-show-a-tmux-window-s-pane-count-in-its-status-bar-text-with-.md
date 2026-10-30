# Show a tmux window's pane count in its status-bar text with `#{window_panes}`

tmux exposes the number of panes in a window through the `window_panes` format variable. Put it in `window-status-format` and every window tab shows its pane count, so you can spot split windows without switching to them.

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload the config:

```sh
tmux source-file ~/.tmux.conf
```

Now a window with one pane shows `1:editor (1)`, and a window split into three shows `2:logs (3)`. The count updates as you split or join panes, because tmux re-evaluates the format on every status redraw.

To make the current window stand out, keep the pane count only in the current-window format and drop it from the inactive one:

```tmux
set -g window-status-format " #I:#W "
set -g window-status-current-format " #I:#W [#{window_panes}] "
```

Use `#{?window_panes,...}` if you want to hide the count for single-pane windows:

```tmux
set -g window-status-format " #I:#W#{?#{>:#{window_panes},1}, (#{window_panes}),} "
```
