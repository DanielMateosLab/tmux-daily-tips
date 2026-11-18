# Show a tmux window's pane count with a custom format in the status bar

Use the `#{window_panes}` format variable inside `window-status-format` to show how many panes each window contains. It works without any scripting and updates as you split or close panes.

## The format variable

`#{window_panes}` expands to the number of panes in the window. Pair it with `#I` (index) and `#W` (name) inside the status format to build a compact label.

## Example

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format "#I:#W [#{window_panes}]"
set -g window-status-current-format "#[bold,fg=yellow]#I:#W [#{window_panes}]#[default]"
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

Each window in the status bar now reads something like `1:editor [3]`, and the current window is highlighted in yellow. Split a pane with `prefix %` and the count in the status bar updates on the next redraw.

## Tips

- Use `#{?window_panes,...,}` conditionals if you only want the count shown when a window has more than one pane.
- Pair it with `#{window_zoomed_flag}` to also show a `Z` when a pane is zoomed.
