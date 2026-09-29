# Cycle Through Pane Layouts with next-layout and previous-layout

**Shortcut:** `next-layout` and `previous-layout`

**Command:**
```
tmux next-layout        # Move to the next layout in the rotation
tmux previous-layout    # Move to the previous layout in the rotation
```

**Explanation:**
Tmux rotates through predefined pane layouts (tiled, even-horizontal, even-vertical, main-horizontal, main-vertical). Instead of selecting a specific layout by name, you can cycle through them instantly with `next-layout` and `previous-layout`. Bind these to keys for seamless layout switching.

**Example:**
Bind cycling to convenient keys in your tmux config:

```
bind C-l next-layout      # Ctrl+L cycles forward through layouts
bind C-h previous-layout  # Ctrl+H cycles backward through layouts
```

Now when you have multiple panes, pressing `Ctrl+L` will instantly rotate to the next layout: tiled → even-horizontal → even-vertical → main-horizontal → main-vertical → tiled. Perfect for quickly rearranging panes without naming specific layouts.

**Pro tip:** Pair this with `select-layout even-horizontal` to reset to a baseline, then cycle from there.
