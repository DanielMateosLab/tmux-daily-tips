# Navigate Windows Relatively with +1 and -1

Use `select-window -t +1` or `-1` to move forward or back one window without knowing its absolute index.

## Command

```
tmux select-window -t +1  # Next window
tmux select-window -t -1  # Previous window
```

Bind to keys in your config:

```
bind-key n select-window -t +1
bind-key p select-window -t -1
```

## Explanation

Relative window navigation works regardless of numbering gaps. Instead of jumping to a specific index, `+N` moves N positions forward from the current window, and `-N` moves backward. This same notation works in other commands like `select-pane -t +1` or `kill-window -t -1`, giving you consistent, predictable movement across gaps created by deleting windows.

## Example

With windows numbered 0, 2, 4, 5:
- From window 2, pressing `Prefix-n` jumps to window 4.
- From window 4, pressing `Prefix-p` jumps back to window 2.

Skip renumbering and renaming—just move forward and backward intuitively.
