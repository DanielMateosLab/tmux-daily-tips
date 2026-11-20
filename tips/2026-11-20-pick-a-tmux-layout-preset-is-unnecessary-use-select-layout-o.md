# Pick a Tmux Layout Preset Is Unnecessary: Use `select-layout -o` to Undo Your Last Layout Change

Tmux remembers the previous layout of each window, so `select-layout -o` (`-o` for "old") restores the arrangement that was active before your most recent layout change.

## Why it helps

Tmux layout presets like `even-horizontal` or `tiled` rearrange every pane at once. If you apply one by accident, or you want to compare it against the arrangement you had before, you have to rebuild the splits by hand. The `-o` flag swaps back to the prior layout in one step, and running it again toggles between the two.

## Example

Suppose you have three panes stacked the way you like them, and you run `select-layout tiled` to see a grid view:

```sh
tmux select-layout tiled
tmux select-layout -o
```

The first command arranges the panes in a grid. The second returns them to the stacked arrangement you had before. Bind it to a key so you can flip between the two layouts while you work:

```tmux
bind o select-layout -o
```

With that binding, `prefix + o` toggles the window back and forth between its last two layouts. Note that `-o` only remembers one step back, so a second change overwrites the saved layout.
