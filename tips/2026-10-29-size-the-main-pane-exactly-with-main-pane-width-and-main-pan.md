# Size the main pane exactly with `main-pane-width` and `main-pane-height`

The `main-vertical` and `main-horizontal` layouts give one large pane and stack the rest beside or below it. By default tmux sizes that main pane automatically. Setting `main-pane-width` or `main-pane-height` fixes its size, so the layout stays the same across terminal resizes.

## The options

- `main-pane-width` sets the width of the main pane in `main-vertical` layouts.
- `main-pane-height` sets the height of the main pane in `main-horizontal` layouts.

Both accept a number of columns or rows, or a percentage such as `60%`.

## Example

Add this to `~/.tmux.conf`, then reload it with `prefix + r` if you bind it, or with `tmux source-file ~/.tmux.conf`:

```
set -g main-pane-width 60%
set -g main-pane-height 70%

bind M select-layout main-vertical
bind N select-layout main-horizontal
```

Press `prefix + M` to put the focused window into a 60% wide main pane with the other panes stacked on the right. Press `prefix + N` for a 70% tall main pane with the others in a row beneath it.

The sizes apply each time tmux builds one of these layouts, so you can resize the terminal window and the main pane keeps its proportion. Manual resizes with `resize-pane` last only until the next layout change.

## Tip

Use the percentage form for a window you share across machines with different screen sizes. A fixed column count such as `120` can leave the main pane too narrow on a smaller terminal.
