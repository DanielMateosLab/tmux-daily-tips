# Clear the Screen Programmatically with send-keys C-l

## The command
```
send-keys C-l
```

## Why this matters
Sometimes you want to clear the current view in a pane without affecting scrollback. Sending C-l (Ctrl-L) clears the visible screen, just like typing Ctrl-L manually. This is useful in scripts or keybindings to keep panes clean between operations.

## Example
Clear the current pane:
```
tmux send-keys -t mywindow C-l
```

Create a keybinding to clear the current pane:
```
bind-key C-l send-keys -t "#{pane_id}" C-l
```

In a script, clear multiple panes before running commands:
```
tmux send-keys -t work C-l
tmux send-keys -t work "npm test" Enter
```

Clear all panes in the current window:
```
tmux list-panes -F "#{pane_id}" | xargs -I {} tmux send-keys -t {} C-l
```
