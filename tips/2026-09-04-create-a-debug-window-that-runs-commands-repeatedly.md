# Create a debug window that runs commands repeatedly

**Setup:**
```tmux
tmux new-window -n debug
tmux send-keys -t debug "watch -n 2 'docker ps -a'" Enter
```

**Explanation:**
Create a dedicated monitoring window that runs a command on repeat. Use `watch` (or a shell loop) to continuously refresh output at fixed intervals without manual re-execution. Perfect for tracking logs, processes, or git status in real-time while you work elsewhere.

**Example:**
```tmux
# Monitor Docker containers every 3 seconds
tmux new-window -n docker
tmux send-keys -t docker "watch -n 3 'docker ps -a && echo && docker stats'" Enter

# Or use a shell loop if watch isn't available
tmux send-keys -t debug "while true; do clear; npm test; sleep 5; done" Enter
```

Then jump to your debug window with `Prefix w` (window chooser) or bind a quick hotkey:
```tmux
bind-key C-d select-window -t debug
```
