# Preemptively Start the tmux Server with `start-server`

**Command:**
```
tmux start-server
```

**What it does:**
By default, tmux starts its server daemon on first use. If you want to initialize the server before creating any sessions (useful for preloading config, hooks, or background processes), use `start-server`. This is a no-op if the server is already running, but it guarantees the server and all global options are loaded.

**Why it's useful:**
- Ensures hooks and global config are active before any client attaches
- Enables background tasks via `run-shell` to start immediately
- Useful in startup scripts or CI/CD pipelines where you need tmux ready before launching sessions
- Reduces latency on the first session creation

**Example:**

In your shell profile or startup script:
```bash
# Start tmux daemon early to load hooks and background processes
tmux start-server

# Now create a background monitoring session
tmux new-session -d -s monitor -n logs 'tail -f /var/log/app.log'

# Attach when ready
tmux attach -t monitor
```

Or in a dotfile setup script:
```bash
#!/bin/bash
tmux start-server
tmux source-file ~/.tmux.conf
tmux list-sessions  # Confirm server is ready
```
