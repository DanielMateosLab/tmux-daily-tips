# Pick a Pane Layout Preset Relative to the Current One with `select-layout -n` and `-p`

tmux cycles through layout presets with `next-layout` and `previous-layout`, but `select-layout` also accepts `-n` (next) and `-p` (previous) flags. That lets you step through presets from a script or a `bind-key` without needing the prefix-key sequence to be mapped to those specific commands.

## The Command

```
tmux select-layout -n
tmux select-layout -p
```

- `-n` applies the next preset in the cycle.
- `-p` applies the previous preset.

Both act on the current window, so they work well inside `run-shell` or from a script that targets a specific window with `-t`.

## Why It Helps

Scripts often need to change layout without knowing which preset is active. Instead of hardcoding `even-horizontal` or `main-vertical`, you can step forward or backward from whatever layout is already in place. This is useful when a script adds or removes panes and you want the window to shift to the next arrangement.

## Example

Bind two keys to step through layouts in both directions, and use a script that steps once after creating a pane:

```
# ~/.tmux.conf
bind-key > select-layout -n
bind-key < select-layout -p
```

```
# Create a pane, then advance the layout one step
tmux split-window -t mysession:0 -v
tmux select-layout -t mysession:0 -n
```

Press `prefix` then `>` to advance the layout, and `prefix` then `<` to go back. Both keys work without needing to remember the preset names.
