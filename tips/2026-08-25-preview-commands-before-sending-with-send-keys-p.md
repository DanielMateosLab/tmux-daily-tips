# Preview commands before sending with send-keys -p

**The flag:**
```
tmux send-keys -p -t <target> <keys>
```

**What it does:**
The `-p` flag prints the exact keys that would be sent to stdout without actually sending them to the pane. Invaluable for validating script-generated commands before execution.

**Example:**
```bash
# Preview a command
tmux send-keys -p -t mywindow "echo test" Enter
# Output: echo test<Enter>

# Validate before sending in production scripts
if tmux send-keys -p -t remote "rm -rf /" Enter | grep -q "rm -rf"; then
  echo "Blocked dangerous command"
  exit 1
fi

# Now safely send it
tmux send-keys -t remote "safe-command" Enter
```

**Use it for:**
- Debugging key sequences in automation scripts
- Validating generated commands before execution
- Logging what gets sent to remote sessions
- One final check before destructive operations in production
