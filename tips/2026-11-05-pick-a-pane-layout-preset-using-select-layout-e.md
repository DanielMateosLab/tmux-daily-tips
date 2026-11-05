# Pick a Pane Layout Preset Using `select-layout -E`

Tmux's `select-layout` command accepts a `-E` flag that spreads the panes in the current window evenly. This is a quick way to reset a messy layout without cycling through presets one by one.

## Command

```
tmux select-layout -E
```

Bind it to a key for one-press cleanup in `~/.tmux.conf`:

```
bind E select-layout -E
```

After reloading the config with `prefix` + `:` then `source-file ~/.tmux.conf`, pressing `prefix` + `E` evens out every pane.

## Explanation

Tmux has five built-in layout presets: `even-horizontal`, `even-vertical`, `main-horizontal`, `main-vertical`, and `tiled`. Cycling with `Space` works, but when you just want equal-sized panes regardless of which preset is active, `-E` applies the even layout to the current window's arrangement without requiring you to know which preset comes next.

Use `-E` when you have added or closed several panes and the sizes are lopsided. The command only affects the active window, so other windows keep their layouts.

## Example

Start with three panes, one much larger than the others:

```
tmux new-session -d -s demo
tmux split-window -h -t demo
tmux split-window -v -t demo
tmux resize-pane -t demo:0.0 -x 80
tmux select-layout -E -t demo
tmux attach -t demo
```

The `resize-pane` call makes the left pane 80 columns wide, which skews the layout. Running `select-layout -E` afterward redistributes the space so all panes are roughly equal again.
