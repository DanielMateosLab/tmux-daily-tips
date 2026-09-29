# Use send-keys with printf-Style Formatting to Build Dynamic Commands

You can combine `send-keys` with shell command substitution and variable expansion to build complex, context-aware commands on the fly. This enables powerful automation without hardcoding values into your tmux configuration.

**Basic example:**
```bash
tmux send-keys -t pane "git log --oneline | head -$(tmux display-message -p '#{window_width}')"
```

**In a keybinding:**
```bash
bind-key C-d send-keys -t pane "ls -la $(tmux display-message -p '#{pane_current_path}')"
```

**Explanation:**
Use `#{format-variables}` in `display-message -p` to inject tmux state into commands. This lets you build commands that adapt to the current window size, pane location, session name, or any other tmux variable.

**Practical example — Jump to a file based on window width:**
```bash
bind-key M-f send-keys -t pane \
  "tail -$(tmux display-message -p '#{window_height}') /var/log/app.log"
```

**Pro tip:**
Combine with `run-shell` to execute shell commands and inject the result:
```bash
tmux run-shell 'USER=$(whoami); tmux send-keys -t pane "ssh $USER@server"'
```

This is faster than manually typing commands that depend on your current tmux context, and makes your keybindings adaptive to different pane sizes and sessions.
