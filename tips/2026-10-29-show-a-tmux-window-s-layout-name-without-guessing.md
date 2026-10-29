# Show a tmux Window's Layout Name Without Guessing

Every tmux window has a layout (like `even-horizontal`, `tiled`, or a custom arrangement). Use the `window_layout` format variable to read the current layout string, and `#{window_layout}` in the status bar to keep it visible at a glance.

## Check the layout from the command line

```sh
tmux display-message -p '#{window_layout}'
```

This prints the window's layout checksum and geometry string, for example:

```
b5d8,159x48,0,0{79x48,0,0,0,79x48,80,0,1}
```

The string encodes every pane's size and position. You can save it and restore it later with `select-layout`, which is useful for scripting.

## Show the layout in the status bar

Add this to `~/.tmux.conf` so every window displays its layout string on the right side of the status bar:

```tmux
set -g status-right '#{window_layout}'
```

To keep the status bar readable, you can truncate the value:

```tmux
set -g status-right '#{=20:window_layout}'
```

The `=20:` modifier cuts the string to 20 characters.

## Capture the layout to restore later

Save the current layout before a temporary change, then put it back:

```sh
layout=$(tmux display-message -p '#{window_layout}')
# ... rearrange panes, zoom, experiment ...
tmux select-layout "$layout"
```

## Tip

Reading `window_layout` is more reliable than parsing `list-panes` output when you need the exact geometry of every pane in one value.
