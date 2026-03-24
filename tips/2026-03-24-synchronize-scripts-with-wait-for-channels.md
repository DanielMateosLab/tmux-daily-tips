# Synchronize Scripts with `wait-for` Channels

## The Command

```
tmux wait-for <channel>         # block until the channel is signaled
tmux wait-for -S <channel>      # signal (unblock) a waiting channel
tmux wait-for -L <channel>      # lock a channel (mutex)
tmux wait-for -U <channel>      # unlock a channel
```

## What It Does

`wait-for` creates named synchronization channels that let you coordinate between tmux panes, shell scripts, or background jobs. One process blocks on a channel until another process signals it — acting like a simple semaphore built right into tmux.

This is invaluable when scripting multi-pane workflows where one pane must finish setup before another begins.

## Practical Example: Wait for a Server Before Running Tests

Start a dev server in one pane and only run tests after it's ready:

```bash
#!/usr/bin/env bash

SESSION="dev"
tmux new-session -d -s "$SESSION"

# Pane 0: start the server, signal when ready
tmux send-keys -t "$SESSION" \
  'npm run dev & while ! curl -s localhost:3000 >/dev/null; do sleep 0.5; done; tmux wait-for -S server-ready' Enter

# Pane 1: wait for the signal, then run tests
tmux split-window -t "$SESSION"
tmux send-keys -t "$SESSION" \
  'tmux wait-for server-ready && npm test' Enter

tmux attach -t "$SESSION"
```

The second pane blocks at `wait-for server-ready` until the first pane confirms the server is accepting connections and sends `-S server-ready`.

## Using It as a Mutex

Prevent two panes from writing to the same file simultaneously:

```bash
# In any pane that needs exclusive access:
tmux wait-for -L mylock
echo "critical section" >> shared.log
tmux wait-for -U mylock
```

The `-L` flag acquires the lock (blocking if another process holds it), and `-U` releases it.

## Tips

- Channel names are global within a tmux server — use descriptive names to avoid collisions
- `wait-for` without flags blocks the calling shell, so always pair it with a corresponding `-S` or the shell will hang indefinitely
- Combine with `set-hook` to signal channels on tmux events like `pane-exited` or `window-linked`
