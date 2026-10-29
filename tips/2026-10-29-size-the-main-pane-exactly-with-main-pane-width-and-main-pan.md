# Size the main pane exactly with main-pane-width and main-pane-height

The `main-pane-width` and `main-pane-height` options set the exact size of the main pane in the `main-vertical` and `main-horizontal` layouts. Without them, tmux picks a size from the window dimensions, so the main pane shifts whenever the terminal resizes.

## Setting the size

Run these from the command prompt (`prefix :`) or put them in `~/.tmux.conf`:

```
set -g main-pane-width 120
set -g main-pane-height 30
```

`main-pane-width` applies to `main-vertical`, which places the main pane on the left and stacks the others on the right. `main-pane-height` applies to `main-horizontal`, which places the main pane on top. Values are in columns or rows. You can also use a percentage, such as `60%`.

## Applying it to a window

Set the width, then switch to the layout so tmux rebuilds the window with it:

```
tmux set -w main-pane-width 100
tmux select-layout main-vertical
```

Cycle to `main-vertical` with `prefix Space` or `select-layout` once the option is set. Rebuilding the layout is what applies the new width, so changing the option alone does not resize an existing layout.

## Example

A 200-column terminal running an editor on the left and a shell and logs stacked on the right:

```
set -g main-pane-width 120
bind M select-layout main-vertical
```

Now `prefix M` gives the editor exactly 120 columns, and the remaining 79 columns go to the stacked panes. The width stays at 120 across terminal resizes, unlike the default layout, which splits evenly.
