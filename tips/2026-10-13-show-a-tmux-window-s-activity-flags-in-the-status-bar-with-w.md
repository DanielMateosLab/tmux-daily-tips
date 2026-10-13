# Show a tmux window's activity flags in the status bar with `#{window_flags}`

The window list in the status bar can tell you which windows need attention, but only if you include the `window_flags` format variable. tmux sets flags such as `#` (activity), `!` (bell), `~` (silence), `-` (last window) and `*` (current) on each window. Add `#{window_flags}` to `window-status-format` and those markers appear next to every window name.

Check the current value first:

```
tmux show-options -gw window-status-format
```

Then set a format that shows the flags beside each window index and name:

```
tmux set -gw window-status-format " #I:#W#{window_flags} "
tmux set -gw window-status-current-format " #I:#W#{window_flags} "
```

The current window gets its own format, so set both. Otherwise the active window will never show its flags. To make the change permanent, put the same two lines in `~/.tmux.conf` and run `tmux source-file ~/.tmux.conf`.

Suppose window 2 runs a long build and window 4 is a server log. Turn on activity monitoring for both with `prefix` then `:` and `setw -g monitor-activity on`, then switch to window 1. When the build prints output, the status bar shows `2:build#` and you know to look without leaving your current window. Pressing `prefix` then `w` opens the tree, and visiting window 2 clears the flag.
