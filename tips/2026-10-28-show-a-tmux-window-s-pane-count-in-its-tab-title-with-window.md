# Show a tmux window's pane count in its tab title with `window-status-format`

Shows each window's pane count inline in the status bar, so you can spot split-heavy windows without switching to them.

## Option

Set `window-status-format` and `window-status-current-format` with `#{window_panes}`:

```
set -g window-status-format "#I:#W (#{window_panes})"
set -g window-status-current-format "#[bold]#I:#W (#{window_panes})#[nobold]"
```

`#{window_panes}` expands to the number of panes in that window. The current-window format wraps the text in `#[bold]` so the active tab still stands out.

## Example

With a window named `editor` split into three panes, the status bar shows:

```
1:shell (1)  2:editor (3)  3:logs (2)
```

Add the two lines to `~/.tmux.conf` and reload with `prefix` + `:` then `source-file ~/.tmux.conf`. Any window you split or join updates on the next status refresh.
