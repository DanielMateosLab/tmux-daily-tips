# Clear Pane History While Sending Commands with `send-keys -R`

**Command:**
```bash
tmux send-keys -t pane -R "command" Enter
```

**Explanation:**
The `-R` flag clears the pane's entire scrollback history before sending the command. This is useful for starting fresh without cluttering the display with previous output, or for cleaning up sensitive information before taking screenshots/recordings.

**Example:**
Before running a build or test that produces verbose output, clear the history to show only the new output:

```bash
# Clear history and run tests, showing clean output
tmux send-keys -t build-pane -R "npm test" Enter

# Clear before showing log file
tmux send-keys -t logs -R "tail -f app.log" Enter

# Clear after sensitive operations
tmux send-keys -t work -R "echo 'Ready for demo'" Enter
```

**Practical Use Cases:**
- Cleaning the screen before running long commands in recordings or demos
- Removing sensitive output before screenshots
- Starting fresh in a pane without closing it
- Preparing clean logs for inspection

**Combine with other flags:**
```bash
tmux send-keys -t pane -R -l "slowly type this" Enter  # Slow + clear
tmux send-keys -t pane -R -e "echo #{pane_id}" Enter  # Expand vars + clear
```
