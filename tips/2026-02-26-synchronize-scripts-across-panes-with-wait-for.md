# Synchronize Scripts Across Panes with `wait-for`

## The Command

```
tmux wait-for <channel>          # Block until a signal is received
tmux wait-for -S <channel>       # Send a signal to a channel
tmux wait-for -L <channel>       # Lock a channel (mutex)
tmux wait-for -U <channel>       # Unlock a channel
```

## What It Does

`wait-for` lets you create synchronization points between tmux panes or external scripts. One process blocks on a named channel until another process signals it. This turns tmux into a lightweight job coordinator — no temp files, no polling loops, no sleep hacks.

## Why It's Useful

When you run multi-step workflows across panes (e.g., start a database in pane 1, then run migrations in pane 2), you usually resort to `sleep 5` and hope the timing works. `wait-for` replaces guesswork with deterministic signaling.

## Concrete Example

**Scenario:** Start a dev server in one pane, then run integration tests only after the server is ready.

In your startup script:

```bash
#!/bin/bash

# Pane 1: Start the server, signal when ready
tmux send-keys -t mysession:0.0 '
  npm run dev & 
  while ! curl -s http://localhost:3000/health > /dev/null; do sleep 0.5; done
  tmux wait-for -S server-ready
' Enter

# Pane 2: Wait for the server, then run tests
tmux send-keys -t mysession:0.1 '
  echo "Waiting for server..."
  tmux wait-for server-ready
  echo "Server is up — running tests"
  npm test
' Enter
```

**Using it as a mutex** to prevent two panes from writing to the same file simultaneously:

```bash
# In any pane that writes to shared.log:
tmux wait-for -L logfile-lock
echo "$(date) - results from pane $$" >> shared.log
tmux wait-for -U logfile-lock
```

## Key Details

- Channel names are arbitrary strings — pick descriptive names
- `-S` (signal) wakes **all** processes waiting on that channel
- `-L` / `-U` provide mutex semantics — only one holder at a time
- A signal sent before anyone is waiting is **lost** (no buffering), so start the waiter first
- Works from any context: inside panes, from cron jobs, or external scripts — anything that can call `tmux`

## Quick Reference

| Flag | Purpose | Blocks? |
|------|---------|---------|
| *(none)* | Wait for signal | Yes |
| `-S` | Send signal | No |
| `-L` | Acquire lock | Yes (if held) |
| `-U` | Release lock | No |
