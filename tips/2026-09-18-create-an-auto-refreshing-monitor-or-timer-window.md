# Create an Auto-Refreshing Monitor or Timer Window

**Shortcut/Command:**
```
send-keys -t pane "while true; do clear; YOUR_COMMAND; sleep N; done" Enter
```

**Explanation:**
Use a bash loop with `send-keys` to create a self-updating display window without manual refresh. The `clear` between iterations keeps output clean. Perfect for watching logs, system metrics, test results, or countdowns without cluttering your main workflow.

**Examples:**

Watch logs refresh every 2 seconds:
```
tmux send-keys -t monitoring "while true; do clear; tail -20 /var/log/app.log; sleep 2; done" Enter
```

Simple countdown timer while working:
```
tmux send-keys -t sidebar "for i in {30..1}; do clear; echo \"$i seconds remaining\"; sleep 1; done" Enter
```

System resource monitor updating every 3 seconds:
```
tmux send-keys -t dashboard "while true; do clear; df -h; free -h; sleep 3; done" Enter
```

Create a key binding to spawn a quick monitor in a side pane:
```
bind M-m split-window -v -p 30 \; send-keys -t "!.bottom" "while true; do clear; vmstat 1 1; sleep 1; done" Enter
```

**Tip:** Use `C-c` to stop the loop when done—`clear` runs before each iteration, so the pane remains clean even while running.
