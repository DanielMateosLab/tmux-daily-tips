# Use Multiple tmux Servers with -L for Isolated Sessions

**Command:** `tmux -L socket-name`

**What it does:**
By default, tmux uses a socket named `default` to connect all sessions. The `-L` flag lets you create entirely separate tmux servers with different sockets, isolating sessions and configurations completely. Useful for keeping work projects, personal projects, and CI/testing environments completely separate.

**Shortcut:**
- Create session in named server: `tmux -L work new-session -s dev`
- Attach to a session in named server: `tmux -L work attach -t dev`
- List sessions from named server: `tmux -L work list-sessions`
- Kill entire named server: `tmux -L work kill-server`

**Why use this:**
Prevents accidental window/pane mixing between projects, allows different configurations per server, and isolates a crashed tmux instance from affecting other work.

**Example:**

```bash
# Create isolated servers for different contexts
tmux -L work new-session -s backend -d
tmux -L work new-session -s frontend -d
tmux -L personal new-session -s hobby -d

# Each server is completely independent
tmux -L work list-sessions      # Shows: backend, frontend
tmux -L personal list-sessions  # Shows: hobby

# Reconnect anytime
tmux -L work attach -t backend

# Kill a server without affecting others
tmux -L personal kill-server   # Only personal sessions die
tmux -L work list-sessions     # Work sessions unaffected
```

**Bonus:** Set `TMUX_SOCKET=work` as an environment variable in your shell profile to make `-L work` the default for that context.
