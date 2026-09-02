# Send readline shortcuts to edit commands remotely

**Command:** `send-keys -t pane C-u`

Edit commands in any pane without switching focus using standard readline shortcuts. These work in bash, zsh, and most shells using GNU readline.

Common shortcuts:
- `C-u` — delete from cursor to line start
- `C-k` — delete from cursor to line end  
- `C-a` — jump to line start
- `C-e` — jump to line end
- `C-w` — delete previous word
- `C-d` — delete character at cursor

**Example:** Bind a key to clear the line in pane 1 and type a debug command:

```
bind-key M-d send-keys -t 1 'C-u' 'echo $?'
```

Or chain multiple edits:

```
bind-key M-x send-keys -t 1 'C-a' 'debug-' 'C-e'
```

This jumps to the start of a command, prepends `debug-`, then moves to the end — useful for quick command modifications without switching focus.
