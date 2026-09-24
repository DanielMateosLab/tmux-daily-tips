# Use send-keys with Proper Quoting for Complex Variables

**Command:**
```
send-keys -l "text"     # Send literal text without shell interpretation
send-keys "echo '$var'" # Send text through shell (variables expanded)
```

**Explanation:**

When sending commands with `send-keys`, you often need to handle shell variables, paths with spaces, or special characters. The `-l` flag sends literal text without interpreting `$`, `"`, or other shell metacharacters. Without `-l`, tmux passes the text to the shell, which expands variables—useful when you want evaluation, dangerous when you don't.

Choose based on what you need: literal text (`-l`) for exact reproduction, or shell-evaluated text for dynamic values.

**Example:**

```bash
# Store a file path with spaces
path="/home/user/my documents/file.txt"

# Send literally—the shell in the pane won't expand $path
tmux send-keys -l "cat $path"
# Result: the pane sees: cat $path (not evaluated)

# Send for shell evaluation—the pane's shell expands the variable
tmux send-keys "cat '$path'" Enter
# Result: the pane sees: cat '/home/user/my documents/file.txt'

# Combine: inject the variable value, not the variable name
tmux send-keys -l "cat " "$(printf '%q' "$path")"
# Result: properly quoted and safe, even with special characters
```

**Tip:** Use `printf '%q'` to safely quote shell variables when injecting them into commands.
