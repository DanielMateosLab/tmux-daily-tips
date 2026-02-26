

# Resize Panes Precisely with `resize-pane`

## Shortcut

| Action | Key Binding | Command |
|---|---|---|
| Resize pane down | `Prefix + Ctrl-Down` | `resize-pane -D 5` |
| Resize pane up | `Prefix + Ctrl-Up` | `resize-pane -U 5` |
| Resize pane left | `Prefix + Ctrl-Left` | `resize-pane -L 5` |
| Resize pane right | `Prefix + Ctrl-Right` | `resize-pane -R 5` |
| Zoom toggle (fullscreen pane) | `Prefix + z` | `resize-pane -Z` |

## Explanation

While most people drag pane borders with the mouse or use the default arrow-key resizing (which moves by 1 cell at a time), you can resize panes by an exact number of cells in a single command. This is especially useful when scripting layouts or when you need a pane at a precise width — for example, keeping a log tail at exactly 20 lines tall.

The `-D`, `-U`, `-L`, `-R` flags control direction, and the trailing number sets how many cells to move the border.

## Example: Script a Development Layout

```bash
# Create a 3-pane layout: editor top, logs bottom-left, shell bottom-right
tmux split-window -v
tmux split-window -h
tmux select-pane -t 0

# Make the top editor pane take 70% of vertical space
tmux resize-pane -t 0 -y 70%

# Give the bottom-left log pane exactly 80 columns
tmux resize-pane -t 1 -x 80
```

## Bonus: Percentage-Based Sizing

tmux 3.1+ supports percentage values with `-x` and `-y`:

```bash
# Set pane width to 40% of the window
tmux resize-pane -x 40%

# Set pane height to 25% of the window
tmux resize-pane -y 25%
```

This makes layouts portable across different terminal sizes.
