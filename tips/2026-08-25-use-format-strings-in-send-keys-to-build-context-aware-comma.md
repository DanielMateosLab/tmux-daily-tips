# Use Format Strings in send-keys to Build Context-Aware Commands

Use tmux format variables in `send-keys` to dynamically build commands that reference pane properties like current directory, pane ID, or window name.

**Command:**
```bash
tmux send-keys -t target "command #{format_variable}" Enter
```

**Common Format Variables:**
- `#{pane_current_path}` — current working directory in pane
- `#{pane_current_command}` — command currently running
- `#{window_name}` — name of the window
- `#{session_name}` — name of the session
- `#{pane_id}` — pane ID (e.g., %0)
- `#{window_id}` — window ID
- `#{pane_pid}` — process ID of pane shell

**Example 1: Open editor in same directory as target pane**
```bash
tmux send-keys -t work "$EDITOR #{pane_current_path}/file.txt" Enter
```

**Example 2: Create a log alias for the current session**
```bash
tmux send-keys -t admin "alias logs='tail -f /var/log/#{session_name}.log'" Enter
```

**Example 3: Jump to the same pane in another window**
```bash
tmux send-keys -t dev "ps aux | grep #{pane_pid}" Enter
```

**Example 4: Script to run a command in all panes using their directories**
```bash
for pane in $(tmux list-panes -t session -F "#{pane_id}"); do
  tmux send-keys -t $pane "pwd > /tmp/pane_#{pane_id}.txt" Enter
done
```

Format variables are expanded by tmux before sending, so they always reflect current pane state—useful for automating context-dependent workflows without hardcoding paths or names.
