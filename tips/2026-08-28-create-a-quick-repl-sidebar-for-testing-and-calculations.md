# Create a Quick REPL Sidebar for Testing and Calculations

**Keybinding:**
```
bind C-r split-window -h -p 30 -c "#{pane_current_path}" "python3"
```

**Explanation:**
Quickly spawn an interactive Python environment in a 30%-width sidebar to the right, keeping the current working directory. The sidebar stays alongside your main work, perfect for quick math, imports, API testing, or ad-hoc data manipulation without breaking focus or opening a new terminal.

**Example:**
```bash
# Add to ~/.tmux.conf, then reload
bind C-r split-window -h -p 30 "python3"

# In tmux: Ctrl+Prefix+R opens Python REPL on the right
>>> import json
>>> d = {"key": "value"}
>>> json.dumps(d)
'{"key": "value"}'

# Kill the sidebar with Prefix+X when done
```

**Variants:**
- Replace `python3` with `node`, `irb` (Ruby), `bc` (calculator), or `ghci` (Haskell)
- Use `-l 20` instead of `-p 30` for a bottom sidebar (20 lines height)
- Add `-S` to the split-window to make it synchronize panes (type in both at once)
