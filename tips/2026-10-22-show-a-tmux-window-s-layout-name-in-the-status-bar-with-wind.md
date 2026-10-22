# Show a tmux window's layout name in the status bar with `#{window_layout}`

tmux stores the geometry of every window as a layout string. While the layout string is precise, it is hard to read. The `window_layout` format variable exposes that string, and you can use it in the status bar to show a compact label such as the arrangement of panes in each window.

For a quick check, run this from any pane:

```sh
tmux display-message -p '#{window_layout}'
```

The output looks something like `d3a2,190x50,0,0{95x50,0,0,0,94x50,96,0,1}`. The string is long and mostly useful for scripts, so we'll reduce it to something easier to read.

## Example: show the layout string in the status bar

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format ' #I:#W [#{window_layout}] '
set -g window-status-current-format ' #I:#W [#{window_layout}] '
```

Then reload the config:

```sh
tmux source-file ~/.tmux.conf
```

Each window's tab now includes its layout string. This is handy when you want to save an exact arrangement with `select-layout` or compare two windows at a glance.

## Example: show a short fingerprint instead of the full string

The full layout string can be wide. Pipe it through `cksum` in a `#()` command to get a short, stable fingerprint that changes whenever the arrangement changes:

```tmux
set -g window-status-format ' #I:#W <#(echo "#{window_layout}" | cksum | cut -c1-4)> '
set -g window-status-current-format ' #I:#W <#(echo "#{window_layout}" | cksum | cut -c1-4)> '
```

Two windows with the same four-character tag have the same pane geometry, which is useful for spotting duplicate layouts across a session.

## Notes

- `window_layout` only reflects geometry. Pane contents, titles, and commands are not included.
- Because the value changes on every resize, expect the status bar to update when you resize panes.
- The `#()` shell form runs once per status refresh, so keep the command cheap.
