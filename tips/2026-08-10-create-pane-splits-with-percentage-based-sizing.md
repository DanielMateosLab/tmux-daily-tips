# Create Pane Splits with Percentage-Based Sizing

Instead of eyeballing pane sizes, use the `-p` (percentage) flag with `split-window` to create reproducible layouts.

## Shortcut

```
tmux split-window -h -p 30
```

## Explanation

The `-p` flag sets the size of the *new pane* as a percentage of the available space:

- `-h -p 30` → new pane takes 30% of the width
- `-v -p 25` → new pane takes 25% of the height

This is more reliable than resizing manually, especially when automating session layouts.

## Examples

Split vertically with the new pane taking 40% of the height:

```
tmux split-window -v -p 40
```

Bind percentage splits to keys for quick repeatable layouts:

```
bind-key V split-window -v -p 25
bind-key H split-window -h -p 33
```

Automate a multi-pane layout in a script:

```
tmux new-session -d -s work -c ~/project
tmux split-window -t work -h -p 25       # 25% left, 75% right
tmux split-window -t work:0.1 -v -p 50  # split the right pane
```

The percentage is calculated from the space *before* the split, so layouts remain consistent across terminal sizes.
