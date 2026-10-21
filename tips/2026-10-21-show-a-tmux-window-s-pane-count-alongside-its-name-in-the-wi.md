# Show a tmux window's pane count alongside its name in the window list

Sometimes you need to know which window hides a split layout before you switch to it. The `#{window_panes}` format variable holds the pane count, so you can print it next to each window name in the status bar without any extra commands.

## The command

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Both options control how each entry in the status bar's window list renders. `window-status-format` covers inactive windows and `window-status-current-format` covers the active one, so set both or the current window will lack the count.

## Example

Add the two lines to `~/.tmux.conf`, then reload:

```
tmux source-file ~/.tmux.conf
```

With three windows, one of them split into four panes, the status bar shows:

```
 1:shell (1)   2:server (4)   3:logs (2)
```

You can see at a glance that window 2 holds four panes, without switching to it. To test the format before committing it to the config, run `tmux display-message -p '#{window_panes}'` in any pane; it prints the pane count of the current window.
