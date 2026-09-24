# Batch Rename Windows Using a Pattern

**Command:**
```bash
for i in $(tmux list-windows -t <session> -F "#{window_index}"); do
  tmux rename-window -t "<session>:$i" "work-$i"
done
```

**Explanation:**
Quickly rename multiple windows at once using a naming pattern. Useful for organizing windows programmatically, applying naming conventions, or resetting names after bulk operations.

**Example:**
```bash
# Rename all windows in current session to "dev-1", "dev-2", etc.
for i in $(tmux list-windows -F "#{window_index}"); do
  tmux rename-window -t ":$i" "dev-$i"
done

# Or with custom prefixes from git branch or directory:
for i in $(tmux list-windows -t mysession -F "#{window_index}"); do
  branch=$(tmux send-keys -t "mysession:$i" "git rev-parse --abbrev-ref HEAD 2>/dev/null" \; echo | head -1)
  tmux rename-window -t "mysession:$i" "${branch:-untitled}-$i"
done

# Reset all windows to default names (remove custom renaming):
for i in $(tmux list-windows -F "#{window_index}"); do
  tmux rename-window -t ":$i" "$i"
done
```

This approach beats manual renaming and works great in scripts or startup functions.
