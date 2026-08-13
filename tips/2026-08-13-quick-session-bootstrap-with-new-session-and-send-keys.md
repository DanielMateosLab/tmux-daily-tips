# Quick Session Bootstrap with new-session and send-keys

Combine `new-session`, `new-window`, and `send-keys` to create pre-configured tmux sessions instantly.

**Commands:**
```
tmux new-session -d -s myproject -c ~/project
tmux new-window -t myproject -n editor
tmux send-keys -t myproject:editor "vim app.js" Enter
tmux new-window -t myproject -n server -c ~/project/server
tmux send-keys -t myproject:server "npm run dev" Enter
tmux attach -t myproject
```

**Explanation:**
Instead of manually creating windows and running commands, script the entire session setup. This creates a session, adds named windows in specific directories, and starts processes automatically—all in one command or shell script.

**Example:**
Save this as `dev-session.sh`:
```
#!/bin/bash
tmux new-session -d -s dev -c ~/myproject
tmux new-window -t dev -n editor
tmux send-keys -t dev:editor "vim ." Enter
tmux new-window -t dev -n server
tmux send-keys -t dev:server "npm start" Enter
tmux new-window -t dev -n logs
tmux send-keys -t dev:logs "tail -f *.log" Enter
tmux attach -t dev
```

Then run: `bash dev-session.sh`

This instantly creates a complete development workspace with editor, server, and log monitoring in separate windows—no manual setup required.
