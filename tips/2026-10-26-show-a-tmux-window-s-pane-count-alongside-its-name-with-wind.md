# Show a tmux Window's Pane Count Alongside Its Name with `window-status-format`

Need to know how many panes a window holds without switching to it? You can display the pane count right in the window tab using the `#{window_panes}` format variable in `window-status-format` and `window-status-current-format`.

## The Format Variable

`#{window_panes}` expands to the number of panes in each window. Combine it with `#I` (index) and `#W` (name) to build a compact tab label.

## Configuration

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format "#I:#W (#{window_panes})"
set -g window-status-current-format "#I:#W (#{window_panes})*"
```

Then reload:

```tmux
tmux source-file ~/.tmux.conf
```

## Example

With three windows, where window 2 has four panes and is active, your status bar shows:

```
[0] 0:shell (1)  1:logs (2)  2:build (4)*
```

The `*` marks the current window, and the parenthesized number is the pane count. This makes it easy to spot split-heavy windows at a glance, and you can verify the value anytime with:

```tmux
tmux display-message -p -t :2 "#{window_panes}"
```
