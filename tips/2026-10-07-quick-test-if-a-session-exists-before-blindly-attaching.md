# Quick test if a session exists before blindly attaching

**Command:**
```bash
tmux has-session -t SESSION_NAME && tmux attach-session -t SESSION_NAME || tmux new-session -s SESSION_NAME
```

**Explanation:**
`has-session` safely checks if a session exists without creating it. This prevents accidental session creation during automation or scripts. Use it as a guard before `attach-session` or when building conditional logic.

**Why it matters:**
Blindly running `tmux attach-session` on a nonexistent session fails silently in some shells. `has-session -t name` exits 0 if the session exists, 1 otherwise, making it perfect for conditionals and error handling.

**Example:**
Check if your "work" session is already running, attach if it exists, create it if not:

```bash
tmux has-session -t work && tmux attach-session -t work || tmux new-session -s work -c ~/projects
```

In a script, gate operations on session existence:

```bash
if tmux has-session -t build; then
  tmux send-keys -t build "make test" Enter
else
  echo "Build session not running"
fi
```

Combine with loop to kill only sessions that exist:

```bash
for session in old-1 old-2 old-3; do
  tmux has-session -t "$session" && tmux kill-session -t "$session"
done
```
