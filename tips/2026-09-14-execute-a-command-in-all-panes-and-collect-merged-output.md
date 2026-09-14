# Execute a command in all panes and collect merged output

## Command

```
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | while read pane; do
  tmux send-keys -t "$pane" 'your-command' Enter
  sleep 1  # optional: pause between panes
done
tmux capture-pane -t <session> -p -e -S -100 | tee /tmp/merged-output.txt
```

## Explanation

Run the same command across all panes in your tmux session and aggregate their output in one place. This is useful for bulk operations like checking deployment status, running linters across projects, or collecting system information.

The `-a` flag targets all panes across all sessions and windows. Each pane executes your command with `send-keys`, then `capture-pane` collects the merged history. The output is saved to a file for further processing or archiving.

## Example

```bash
# Check disk usage in all panes
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | while read pane; do
  tmux send-keys -t "$pane" 'df -h | grep -E "Filesystem|/$"' Enter
done

# Collect all output
tmux capture-pane -t mywork -p -S -200 | tee check-results.txt
```

For a single window, use `list-panes -F` without `-a` and filter by session/window.
