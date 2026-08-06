# List All Windows in a Session with list-windows

Query all windows in a session to find and automate operations on specific windows.

## Command

```
tmux list-windows -t session_name
```

## Example

```bash
# List all windows in the dev session
tmux list-windows -t dev

# Count windows
tmux list-windows -t dev | wc -l

# Find a window by name and send a command
window=$(tmux list-windows -t dev | grep editor | cut -d: -f1)
tmux send-keys -t dev:$window 'make' Enter

# Check if a specific window exists in a script
if tmux list-windows -t dev | grep -q editor; then
  tmux send-keys -t dev:editor 'make' Enter
fi
```

## Output Format

```
0: bash
1: editor (226x56)
2: test*
```

Columns: index, name, size, flags (* = active, - = last active, Z = zoomed).

## When to Use

Build automation scripts that operate on named windows without hardcoding indices. Query your session structure programmatically from shell scripts and custom functions.
