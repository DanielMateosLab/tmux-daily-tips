# Show a tmux window's pane count in the window's tab style with `window-status-format`

Pane count is a useful signal, but it is hidden until you switch to the window. Put it into the window tab itself by editing `window-status-format` and `window-status-current-format`, using the `#{window_panes}` format variable.

Unlike the existing tips that show pane counts in the status bar or window name, this one styles the count per tab, so you can read the layout of every window at a glance.

## Example

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format         "#I:#W #[fg=colour244]([#{window_panes}])"
set -g window-status-current-format "#I:#W #[fg=colour208,bold]([#{window_panes}])"
```

Reload the config:

```sh
tmux source-file ~/.tmux.conf
```

Each tab now reads like `2:editor ([3])`, and the current window is highlighted in orange. Windows with a single pane show `([1])`, so a window that was split and then closed is easy to spot.

## How it works

`window-status-format` controls how each inactive window tab is drawn, and `window-status-current-format` controls the active one. Both accept format variables. `#{window_panes}` expands to the number of panes in that window, and `#[...]` inline styles colour just that fragment without changing the rest of the tab.

To check the value for any window before editing the format, run:

```sh
tmux display-message -p -t :2 '#{window_panes}'
```

Replace `:2` with the window index you want to inspect.
