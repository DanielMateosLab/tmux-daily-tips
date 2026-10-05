# Save Pane Output to a Persistent Scratch File

Create a quick note or command log in a dedicated pane that auto-updates as you work.

**Command:**
```
bind-key -n M-n new-window -n notes -c /tmp "tail -f session-notes.txt"
```

**Explanation:**
Bind `Alt+N` to open a persistent notes window that tails a file. Then append output from your main panes with `send-keys` or `run-shell`. This gives you a live log without leaving the pane, useful for tracking commands, errors, or quick thoughts while coding.

**Example:**
```bash
# In your main pane, append the current command to the notes
tmux send-keys -t notes "$(date): Running tests..." Enter

# Or pipe command output
tmux send-keys -t main "mycommand | tee -a /tmp/session-notes.txt" Enter

# From a hook: log when switching windows
set-hook -g after-select-window "run-shell 'echo \"Switched at $(date)\" >> /tmp/session-notes.txt'"
```

Makes it trivial to maintain a session diary or command history without context switching.
