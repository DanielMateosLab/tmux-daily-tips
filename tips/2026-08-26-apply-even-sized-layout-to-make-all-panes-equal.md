# Apply Even-Sized Layout to Make All Panes Equal

Use the `even-vertical` or `even-horizontal` layouts to distribute panes equally across your window, useful when manual resizing has left them unevenly distributed.

## Command

```
tmux select-layout even-vertical
tmux select-layout even-horizontal
```

## Explanation

- `even-vertical`: stacks all panes vertically with equal height
- `even-horizontal`: arranges all panes horizontally with equal width
- Resets layout to a fair distribution after manual resizing
- Apply to a specific window with `-t window-id`

## Example

```
# Arrange all panes in the current window vertically with equal height
tmux select-layout even-vertical

# Apply to a specific window
tmux select-layout -t dev:1 even-horizontal

# Quickly switch between even and tiled layouts
tmux select-layout even-vertical
tmux select-layout tiled
```

When monitoring multiple services or comparing logs side-by-side, even-sized panes ensure each output is equally visible without fiddling with borders.
