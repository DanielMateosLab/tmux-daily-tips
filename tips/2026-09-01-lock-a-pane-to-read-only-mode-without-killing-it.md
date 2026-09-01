# Lock a Pane to Read-Only Mode Without Killing It

**Command:** `select-pane -d` (disable input) and `select-pane -e` (enable input)

Prevent accidental typing in a pane while monitoring live output. The pane continues updating but rejects keyboard input, and focus automatically moves to other panes when you type.

**Setup:**
```
bind x select-pane -d  # lock current pane
bind X select-pane -e  # unlock current pane
```

**Example:**
```
# Pane 1 shows: tail -f /var/log/app.log
# You're reading logs, about to type something...
# Press Prefix x — now pane 1 is locked
# Your keystrokes go to adjacent panes, not into logs
# Logs keep streaming in pane 1
# Press Prefix X to unlock when you need to interact with it
```

Useful for long-running streams, scrolling logs, or monitoring dashboards where a stray keystroke could interrupt your view or execute unwanted commands.
