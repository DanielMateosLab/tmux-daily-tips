# Use ANSI color codes with send-keys to create colorized output markers

## Shortcut/Command
```
tmux send-keys "echo -e '\\033[32m[SUCCESS]\\033[0m Your output'", Enter
```

## Explanation
You can inject raw ANSI color codes through `send-keys` to add visual markers to pane output without needing terminal configuration. This is useful for highlighting key points, warnings, or status messages in interactive panes.

The basic ANSI codes:
- `\033[32m` — green
- `\033[31m` — red
- `\033[33m` — yellow
- `\033[0m` — reset to default

Use `-e` in `echo` to interpret escape sequences, or directly send the raw bytes.

## Practical Example
Monitor test output with color-coded results:

```bash
# Mark passing test
tmux send-keys -t mywindow "echo -e '\\033[32m✓ PASS\\033[0m: Database check'" Enter

# Mark failing test
tmux send-keys -t mywindow "echo -e '\\033[31m✗ FAIL\\033[0m: Connection timeout'" Enter

# Warning marker
tmux send-keys -t mywindow "echo -e '\\033[33m⚠ WARN\\033[0m: High memory usage'" Enter
```

Or in a loop across multiple panes:
```bash
for pane in $(tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}'); do
    tmux send-keys -t "$pane" "echo -e '\\033[36m[BROADCAST]\\033[0m Updated at $(date)'" Enter
done
```

This is cleaner than relying on external tools and works over SSH where color config might not persist.
