# Kill All Other Sessions Instantly

Close every other session with a single command.

**Command:**
```
kill-session -a
```

**Explanation:**
The `-a` flag on `kill-session` terminates all sessions except the one you're currently attached to. This is a quick way to clean up multiple sessions before logging out or when you want to start with a fresh slate without navigating to each session individually.

**Example:**
```
# You have three sessions: dev, build, testing
# You're attached to dev
tmux kill-session -a

# Result: only dev remains
```

To kill all sessions including the current one:
```
tmux kill-server
```
