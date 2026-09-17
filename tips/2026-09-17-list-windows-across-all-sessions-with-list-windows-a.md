# List windows across all sessions with list-windows -a

**Command:** `tmux list-windows -a`

Show windows from every session at once, useful for finding a specific window without switching sessions.

**Usage:**
```
tmux list-windows -a                    # All windows in all sessions
tmux list-windows -a -F '#{session_name}:#{window_index} #{window_name}'
tmux lsw -a | grep logs                 # Find "logs" window
```

**Example:**

Multiple sessions running. Find the "monitoring" window without digging through each session:

```
$ tmux list-windows -a
dev:0    editor
dev:1    shell
work:0   monitoring
work:1   deploy

$ tmux select-window -t work:0
```

Without `-a`, `list-windows` only shows the current session's windows. With it, you see everything at once, making it easy to jump between windows across different sessions.

Combine with `-F` to customize columns or `grep` to filter by name.
