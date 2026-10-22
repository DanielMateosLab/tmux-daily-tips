# Show a tmux Window's Layout Name in the Status Bar with `#{window_layout}`

tmux stores a window's current layout as a string (the same string `select-layout` and `list-windows` use internally). Format variables let you show it directly in the status bar, which helps when you're juggling several layouts and want to know which one you're in without cycling through them.

## The Format Variable

```
#{window_layout}
```

This expands to the full layout description, a checksum-prefixed string such as `d2e4,211x50,0,0{105x50,0,0,1,105x50,106,0,2}`. It is most useful when you pass it through a conditional or a substring to make it readable.

## Example

Add this to `~/.tmux.conf` to show a short, readable identifier for each window's layout:

```tmux
set -g window-status-format \
  " #I:#W #{?#{==:#{window_panes},1},single,#{?#{==:#{window_panes},2},split,multi}} "
```

For a more direct view, add the raw layout string to the right side of the status bar:

```tmux
set -g status-right "#{window_layout}"
```

Reload the config and check the result:

```sh
tmux source-file ~/.tmux.conf
```

## Checking the Value First

Before editing your config, confirm what the variable returns for the current window:

```sh
tmux display-message -p '#{window_layout}'
```

This prints the layout string for the active window. Run it after switching layouts with `select-layout` (or `prefix + space`) to watch the string change.

## Tip

The raw string is long and changes whenever you resize panes, so it's best for debugging or for saving a layout to replay later with `select-layout`. For everyday display, the pane count shown above is usually more useful.
