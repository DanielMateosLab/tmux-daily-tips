# Pick a Fresh Pane Layout Preset Index with `select-layout -t` Reordering Trick

Most people know `select-layout` and `Prefix + Space` for preset layouts, but there is no built-in way to see which layout is currently active by index. Pair `display-message` with `#{window_layout}` to read the exact layout string, then reuse that string later to restore it.

## Show the current layout string

```
tmux display-message -p '#{window_layout}'
```

This prints a checksum-prefixed layout descriptor such as `d6f1,200x50,0,0{100x50,0,0,1,99x50,101,0,2}`. Copy it to restore the exact arrangement later.

## Restore a saved layout

```
tmux select-layout -t :1 'd6f1,200x50,0,0{100x50,0,0,1,99x50,101,0,2}'
```

This reapplies the saved geometry to window 1, even after you have rearranged panes by hand.

## Practical example: save and restore around a temporary zoom-like split

1. Save the layout before a temporary change:

```
tmux set-option -g @saved_layout "$(tmux display-message -p '#{window_layout}')"
```

2. Make whatever changes you need (add splits, resize, or move panes).

3. Restore it:

```
tmux select-layout "$(tmux show-option -gv @saved_layout)"
```

Bind both steps to keys in `~/.tmux.conf` for a quick toggle:

```
bind-key S set-option -g @saved_layout "#{window_layout}"
bind-key R select-layout "#{@saved_layout}"
```

Press `Prefix + S` to capture the layout and `Prefix + R` to restore it.

## Notes

- The layout string is tied to the current pane count. If panes are added or removed, restoring may fail or produce unexpected sizes.
- `#{window_layout}` reflects the window's full layout, including panes hidden by zoom only in the sense of their geometry, so save before zooming.
