# List All Panes Across All Windows and Perform Bulk Operations

## Command
`tmux list-panes -a -F '#{pane_id} #{pane_current_command}'`

## Explanation
The `-a` flag lists all panes across all windows in the current session. Without `-a`, you only see panes in the active window. The `-F` flag formats output using variables like `#{pane_id}`, `#{pane_pid}`, `#{pane_current_command}`, and `#{pane_current_path}`. This is powerful for scripting bulk operations on multiple panes at once without manually switching between windows.

## Example
```bash
# List all panes with their IDs and running commands
tmux list-panes -a -F '#{pane_id}: #{pane_current_command}'

# Kill all panes except those running vim
tmux list-panes -a -F '#{pane_id}:#{pane_current_command}' | \
  grep -v vim | awk -F: '{print $1}' | xargs -I {} tmux kill-pane -t {}

# Send a command to all panes running bash
tmux list-panes -a -F '#{pane_id}:#{pane_current_command}' | \
  grep bash | awk -F: '{print $1}' | xargs -I {} tmux send-keys -t {} 'echo done' Enter
```

Ideal for automation, cleanup, or monitoring all panes in a session.
