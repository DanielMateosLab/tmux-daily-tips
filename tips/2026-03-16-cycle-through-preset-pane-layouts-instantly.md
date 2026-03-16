# Cycle Through Preset Pane Layouts Instantly

## Shortcut

`Prefix + Space` — cycle to the next built-in pane layout.

## What It Does

tmux ships with five built-in layouts that instantly rearrange all panes in the current window:

| Layout | Description |
|---|---|
| `even-horizontal` | All panes side by side, equal width |
| `even-vertical` | All panes stacked, equal height |
| `main-horizontal` | One large pane on top, others in a row below |
| `main-vertical` | One large pane on the left, others stacked right |
| `tiled` | All panes arranged in a grid |

Each press of `Prefix + Space` advances to the next layout in the cycle. No manual resizing or repositioning needed.

## Jump Directly to a Specific Layout

Instead of cycling, apply a layout by name:

```bash
# Apply a specific layout directly
tmux select-layout main-vertical

# Set the "main" pane size (percentage) for main-horizontal/main-vertical
tmux select-layout -t :1 main-vertical
tmux resize-pane -t 0 -x 60%
```

## Practical Example

You have three panes open — an editor, a test runner, and a log tail. You want the editor to dominate the left side with the other two stacked on the right:

```bash
# Apply main-vertical: pane 0 gets the large left column
tmux select-layout main-vertical
```

Not quite right? Just hit `Prefix + Space` to cycle through until the arrangement fits your workflow.

## Bind Your Favorite Layouts to Keys

Add these to `~/.tmux.conf` for one-key access:

```bash
bind-key V select-layout main-vertical
bind-key H select-layout main-horizontal
bind-key T select-layout tiled
```

Now `Prefix + V` immediately snaps to a main-vertical layout — perfect for pairing an editor with auxiliary panes without fiddling with borders.
