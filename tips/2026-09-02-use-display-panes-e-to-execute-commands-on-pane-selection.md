# Use `display-panes -e` to Execute Commands on Pane Selection

## Command
```
tmux display-panes -e "send-keys -t '%%' 'your-command' Enter"
```

## Explanation
`display-panes -e` shows pane numbers and executes a command against whichever pane you select. The `-e` flag takes a command string with `%%` as the placeholder for the selected pane number. This lets you operate on any pane without knowing its address or switching focus.

Perfect for remote operations: inject commands, interrupt processes, or capture output from panes across your layout.

## Example
Send a command to a selected pane:
```bash
tmux display-panes -e "send-keys -t '%%' 'npm test' Enter"
```

Interrupt any running process by selecting its pane:
```bash
bind C-c display-panes -e "send-keys -t '%%' C-c"
```

Copy output from a selected pane to your clipboard:
```bash
tmux display-panes -e "capture-pane -t '%%' -p | pbcopy"
```

Bind a key to quickly send `clear` to any pane:
```
bind C-l display-panes -e "send-keys -t '%%' 'clear' Enter"
```
