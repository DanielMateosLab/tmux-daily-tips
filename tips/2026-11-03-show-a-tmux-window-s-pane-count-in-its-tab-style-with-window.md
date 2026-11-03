# Show a tmux window's pane count in its tab style with `window-status-style`

Pane counts are easy to miss in a crowded status bar. You can tint a window's tab based on how many panes it holds, so split-heavy windows stand out at a glance.

tmux expands format variables inside style strings for window status formats, but `window-status-style` itself is static. The reliable approach is to put the conditional in `window-status-format` with `#{?...}` and use `#[fg=...,bg=...]` inline, so each tab carries its own color based on `#{window_panes}`.

## Example

Add this to `~/.tmux.conf`:

```
set -g window-status-format "#[fg=colour245]#I:#W #{?#{>:#{window_panes},3},#[bg=colour130]#[fg=colour16],#{?#{>:#{window_panes},1},#[bg=colour24]#[fg=colour231],}}#[default]"
set -g window-status-current-format "#[fg=colour16,bg=colour39,bold]#I:#W #{?#{>:#{window_panes},1},(#{window_panes}p),}#[default]"
```

Reload with `prefix + :` then `source-file ~/.tmux.conf`, or press `prefix + r` if you bound it earlier.

Now any inactive window with two or more panes gets a blue tab, and any window with more than three panes switches to an orange tab. The current window shows its pane count in parentheses so you can read it without changing focus.

## Why it works

`#{window_panes}` holds the pane count for each window, and `#{?cond,yes,no}` branches on it. The `#[...]` sequences apply styles to the text that follows them. Because the color is set inside the format string, it renders in each tab independently and needs no per-window option.
