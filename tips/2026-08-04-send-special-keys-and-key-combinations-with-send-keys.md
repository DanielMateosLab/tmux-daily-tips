# Send Special Keys and Key Combinations with send-keys

## Shortcut
```
send-keys -t <target> <key> [<key> ...]
```

## Explanation
Use `send-keys` with special key notation to send actual key presses—not text—to a pane. Combine `C-` (Ctrl), `M-` (Alt), and key names like `Enter`, `Escape`, `Tab`, `Home`, `End`, `C-d`, `C-c`, etc. This is different from sending literal strings; you're triggering actual key events. Useful for sending interrupts, EOF signals, line edits, or simulating user input for automation.

## Example

```bash
# Send Ctrl+C (interrupt)
tmux send-keys -t mywindow C-c

# Send Ctrl+D (EOF / exit bash)
tmux send-keys -t mywindow C-d

# Send Escape (exit vi insert mode)
tmux send-keys -t mywindow Escape

# Send Ctrl+U (delete line in bash/readline)
tmux send-keys -t mywindow C-u

# Send Alt+F (forward word jump in readline)
tmux send-keys -t mywindow M-f

# Chain multiple keys: go to start of line, then Enter
tmux send-keys -t mywindow C-a Enter

# Practical: kill a hung process and restart in one go
tmux send-keys -t build:0 C-c
tmux send-keys -t build:0 "make build" Enter
```

## Use in keybinding
Bind a key to send Ctrl+C to all panes without navigating:

```
bind-key X send-keys -t "{all}" C-c
```
