# Create Windows in the Background

**Shortcut/Command:** `tmux new-window -t session -d`

**Explanation:** The `-d` (detach) flag creates a new window without switching to it, keeping you focused on your current pane. Combine with `-n` to name it and `-c` to set the directory. This is essential for automation: build complex session layouts without context-switching.

**Example:**
```bash
# Start a server in the background while staying in your editor
tmux new-window -t work:5 -d -n "server" -c ~/app
tmux send-keys -t work:server "npm start" Enter

# Create a logging window without losing focus
tmux new-window -t work:6 -d -n "logs"
tmux send-keys -t work:logs "tail -f debug.log" Enter
```

Your main pane stays in focus while infrastructure windows spin up independently. Perfect for session bootstrapping or quick window creation during development.
