# Use list-panes with custom formatting to see all pane details at once

## Command
```
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}: #{pane_current_path} [#{pane_pid}] #{pane_title}'
```

## Explanation
`list-panes` with `-a` (all sessions) shows every pane across all sessions and windows. The `-F` flag customizes the output using format variables.

Useful format variables:
- `#{pane_current_path}` — Working directory
- `#{pane_pid}` — Shell process ID  
- `#{pane_title}` — Custom pane title (if set)
- `#{pane_width}` and `#{pane_height}` — Dimensions
- `#{pane_dead}` — 1 if pane has exited, 0 if alive
- `#{session_name}`, `#{window_index}`, `#{pane_index}` — Location

This is faster than navigating through every pane to find which one is in which directory or if any have crashed.

## Example
```bash
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}: #{pane_current_path} [PID:#{pane_pid}] #{?pane_dead,[DEAD],}'
```

Output:
```
dev:0.0: /home/user/project [PID:12345]
dev:0.1: /home/user/project [PID:12346]
dev:1.0: /home/user/logs [PID:12347]
test:0.0: /home/user/tests [PID:12348] [DEAD]
```

Alias it for quick access:
```bash
alias tmux-panes='tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index}: #{pane_current_path}"'
```
