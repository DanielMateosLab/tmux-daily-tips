

# Send Keys to a Pane Without Switching to It

## Command

```
tmux send-keys -t <target-pane> "command" Enter
```

## What It Does

`send-keys` lets you type commands into any pane from anywhere — another pane, another window, even another session — without switching focus. This is invaluable when you need to trigger actions in background panes while keeping your eyes on your current work.

## The `-t` Target Flag

The target pane can be specified in several ways:

| Format | Meaning |
|---|---|
| `-t 1` | Pane 1 in the current window |
| `-t :2.0` | Pane 0 of window 2 in the current session |
| `-t mysession:1.0` | Pane 0 of window 1 in session "mysession" |
| `-t :.+` | Next pane in the current window |

## Practical Examples

**Restart a dev server running in pane 1 without leaving your editor in pane 0:**

```bash
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "npm run dev" Enter
```

**Run a test suite in another session while you keep coding:**

```bash
tmux send-keys -t tests:0.0 "pytest -x" Enter
```

**Clear a log-tailing pane from your main workspace:**

```bash
tmux send-keys -t 2 C-c
tmux send-keys -t 2 "clear" Enter
tmux send-keys -t 2 "tail -f /var/log/app.log" Enter
```

## Scripting Bonus

Combine `send-keys` in a shell script to orchestrate multi-pane workflows:

```bash
#!/bin/bash
# Start all microservices in their respective panes
tmux send-keys -t dev:0.0 "cd api && cargo run" Enter
tmux send-keys -t dev:0.1 "cd worker && python main.py" Enter
tmux send-keys -t dev:0.2 "cd frontend && npm start" Enter
```

## Key Detail

The `Enter` at the end is literal — it tells tmux to send the Return keystroke. Without it, the command text appears in the pane but never executes. Similarly, `C-c` sends Ctrl+C, and `C-l` sends Ctrl+L (clear screen).
