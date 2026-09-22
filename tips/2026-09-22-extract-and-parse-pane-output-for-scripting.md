# Extract and parse pane output for scripting

`capture-pane -p -e` with `grep`, `sed`, or `awk`

Capture a pane's scrollback and filter it programmatically to trigger automation based on output patterns. This combines `capture-pane` with standard Unix tools to find errors, extract values, or conditionally execute commands.

```bash
# Capture the last 50 lines and search for errors
tmux capture-pane -t mywindow -p -S -50 | grep -i error

# Extract a specific value (like an IP address) from output
IP=$(tmux capture-pane -t mywindow -p | grep "Address:" | awk '{print $2}')

# Monitor for a pattern and trigger a command when found
if tmux capture-pane -t mywindow -p | grep -q "Connection established"; then
  tmux send-keys -t other:pane "some_command" Enter
fi

# Save the last 100 lines with ANSI colors preserved
tmux capture-pane -t mywindow -p -e -S -100 > debug.log
```

Use `-e` to preserve colors and formatting when parsing. Use `-S` (start line) with negative numbers for the last N lines, or `-E` (end line) for a range. Combine with `while read` loops for line-by-line processing in scripts.
