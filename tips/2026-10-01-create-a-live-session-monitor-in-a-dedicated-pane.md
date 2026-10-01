# Create a Live Session Monitor in a Dedicated Pane

**Shortcut/Command:**
```
send-keys -t <pane> "while true; do clear; tmux list-sessions -F '#{session_name}: #{session_windows} windows'; sleep 2; done" Enter
```

**Explanation:**

Create a dedicated pane that continuously displays all active tmux sessions and their window counts, updating every 2 seconds. This is useful when managing multiple long-running sessions—you always know what's active without switching focus.

**Example:**

1. Create a new window for monitoring:
```
tmux new-window -n monitor
```

2. Split it vertically to keep working space:
```
tmux split-window -h -t monitor
```

3. In the left pane, start the monitor loop:
```
tmux send-keys -t monitor.0 "while true; do clear; echo 'Active Sessions:'; tmux list-sessions -F '#{session_name}: #{session_windows} windows'; sleep 2; done" Enter
```

4. Work normally in the right pane (monitor.1) while the left shows live session state.

**Variation with more details:**

```
tmux send-keys -t monitor.0 "while true; do clear; tmux list-sessions -F '#{session_name} | #{session_attached} clients | #{session_windows}w'; sleep 3; done" Enter
```

This adds client count and updates every 3 seconds. Press `C-c` in the monitor pane to stop.
