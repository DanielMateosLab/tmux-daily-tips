# Cycle Through Pane Layouts Instantly with `select-layout`

## Shortcut

`Prefix + Space` — cycles through tmux's five built-in pane layouts.

## What It Does

Instead of manually resizing and repositioning panes, tmux ships with five predefined layouts you can snap to instantly:

| Layout | Description |
|---|---|
| `even-horizontal` | All panes side by side, equal width |
| `even-vertical` | All panes stacked, equal height |
| `main-horizontal` | One large pane on top, others below |
| `main-vertical` | One large pane on the left, others to the right |
| `tiled` | All panes arranged in a grid |

Each press of `Prefix + Space` advances to the next layout in this list.

## Example

Say you have three panes open and they're awkwardly sized after splitting:

```
# Cycle to the next layout
Prefix + Space

# Keep pressing to rotate through all five
Prefix + Space  (again)
Prefix + Space  (again)
```

## Jump Directly to a Specific Layout

You can skip the cycling and go straight to the layout you want:

```bash
# IDE-style: large editor left, small panes stacked right
tmux select-layout main-vertical

# Dashboard-style: large pane on top, utilities below
tmux select-layout main-horizontal

# Equal grid for monitoring
tmux select-layout tiled
```

## Adjust the Main Pane Size

When using `main-vertical` or `main-horizontal`, control how much space the main pane gets:

```bash
# Main pane takes 70% of the width
tmux set-option main-pane-width 70%

# Then apply the layout
tmux select-layout main-vertical
```

## Bind Your Favorite Layout

If you always want one keypress to get your preferred arrangement:

```bash
# In ~/.tmux.conf — bind M-1 through M-5 (already default), or add custom ones:
bind-key M-v select-layout main-vertical
bind-key M-h select-layout main-horizontal
bind-key M-t select-layout tiled
```

## Why This Is Useful

Manually resizing panes is tedious. Layouts let you rearrange everything in a single keystroke — especially handy when you add or remove panes and need to rebalance the workspace quickly.
