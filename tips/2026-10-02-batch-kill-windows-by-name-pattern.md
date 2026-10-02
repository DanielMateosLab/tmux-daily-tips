# Batch kill windows by name pattern

**Command:**

```tmux
kill-window -t SESSION:PATTERN
```

Or to kill all windows matching a pattern:

```bash
tmux list-windows -t SESSION -F "#{window_index}:#{window_name}" | grep PATTERN | cut -d: -f1 | xargs -I {} tmux kill-window -t SESSION:{}
```

**Explanation:**

When managing many windows, you often need to close several at once (e.g., all windows running tests, or leftover SSH sessions). Rather than killing each individually, use `list-windows` to find matching windows and kill them in batch. This is faster than cycling through windows one by one.

**Example:**

Kill all windows with "test" in the name from session "work":

```bash
tmux list-windows -t work -F "#{window_index}:#{window_name}" | grep test | cut -d: -f1 | xargs -I {} tmux kill-window -t work:{}
```

Or create a keybinding to kill all windows except the current one:

```
bind-key X run-shell 'tmux list-windows -t #{session_name} -F "#{window_index}" | grep -v "#{window_index}" | xargs -I {} tmux kill-window -t #{session_name}:{}'
```

This saves time when you've accumulated temporary build, test, or debugging windows.
