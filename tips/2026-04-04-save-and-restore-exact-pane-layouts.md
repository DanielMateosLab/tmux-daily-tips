# Save and Restore Exact Pane Layouts

tmux encodes every pane arrangement as a **layout string** — a compact description of each pane's position and size. You can capture this string and replay it later to recreate an identical layout.

## Get the Current Layout String

```bash
tmux list-windows -F '#{window_name}: #{window_layout}'
```

This prints something like:

```
editor: 5a42,204x51,0,0{102x51,0,0,0,101x51,103,0[101x25,103,0,1,101x25,103,26,2]}
```

That hex-prefixed string after the colon is the full layout descriptor.

## Restore a Saved Layout

Use `select-layout` with the captured string to snap your panes back into shape:

```bash
tmux select-layout '5a42,204x51,0,0{102x51,0,0,0,101x51,103,0[101x25,103,0,1,101x25,103,26,2]}'
```

The panes rearrange instantly to match the exact widths, heights, and positions encoded in the string.

## Practical Workflow

Save your favorite layouts to a file and bind them to keys:

```bash
# In ~/.tmux.conf

# "Dev layout": big editor left, two stacked terminals right
bind D select-layout '5a42,204x51,0,0{102x51,0,0,0,101x51,103,0[101x25,103,0,1,101x25,103,26,2]}'

# "Wide layout": three equal vertical panes
bind W select-layout even-horizontal
```

Or build a quick save/restore alias in your shell:

```bash
# Save current layout
alias tmux-save-layout="tmux list-windows -F '#{window_layout}' | head -1"

# Usage: save it, rearrange freely, then restore
LAYOUT=$(tmux-save-layout)
# ... resize, split, experiment ...
tmux select-layout "$LAYOUT"
```

## Why This Is Useful

The preset layouts (`even-horizontal`, `tiled`, etc.) are convenient but generic. Layout strings let you define **pixel-perfect** custom arrangements — a wide editor with narrow log tails, a monitoring grid, a three-way merge view — and jump back to them with a single keystroke after any accidental resize or reflow.

## Tip

Layout strings are terminal-size dependent. If your terminal dimensions change significantly, the string may not apply cleanly. Re-capture after resizing your terminal emulator.
