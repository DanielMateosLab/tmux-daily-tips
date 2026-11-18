# Show a tmux window's pane count in its status bar with a short label

Stop guessing how many panes a window holds. The `#{window_panes}` format variable returns the pane count, and you can drop it straight into the status bar with a label.

## The format variable

`#{window_panes}` expands to the number of panes in each window. Combined with a literal label, it gives an at-a-glance count next to every window tab.

## Example

Add this to `~/.tmux.conf`:

```
set -g window-status-format " #I:#W [#{window_panes}p] "
set -g window-status-current-format " #I:#W [#{window_panes}p] "
```

Reload the config with `tmux source-file ~/.tmux.conf`. Each window tab now shows something like `1:editor [3p]`, where `3p` is the pane count. The current window uses the second format so its tab looks the same as the others.

To check the value before editing the config, run this in any pane:

```
tmux display-message -p "#{window_panes}"
```

It prints the pane count of the window that holds the pane you ran it in.
