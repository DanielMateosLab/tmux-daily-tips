# Send a Command to Another Pane Without Switching

## The Command

```
tmux send-keys -t {target-pane} "command" Enter
```

## Why It's Useful

When you're working in one pane but need to trigger something in another — restart a server, run a test, tail a log — you don't have to switch focus. `send-keys` lets you type into any pane from where you are, or even from a script.

## Target Syntax

Panes are identified with the format `session:window.pane`:

| Target | Meaning |
|--------|---------|
| `-t 1` | Pane 1 in the current window |
| `-t :.1` | Pane 1 in the current session/window |
| `-t myapp:0.2` | Session "myapp", window 0, pane 2 |
| `-t {right-of}` | The pane to the right of the active one |
| `-t {last}` | The last active pane |

## Concrete Examples

**Restart a dev server running in pane 1 while staying in your editor (pane 0):**

```bash
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "npm run dev" Enter
```

**Run tests in the pane to your right:**

```bash
tmux send-keys -t {right-of} "pytest tests/" Enter
```

**Clear another pane before sending a command:**

```bash
tmux send-keys -t 2 C-l "git status" Enter
```

## Bonus: Use It in Scripts

This is powerful for automation. A simple `dev.sh` startup script:

```bash
#!/bin/bash
tmux new-session -d -s work
tmux split-window -h -t work
tmux split-window -v -t work

tmux send-keys -t work:0.0 "nvim ." Enter
tmux send-keys -t work:0.1 "npm run dev" Enter
tmux send-keys -t work:0.2 "npm run test -- --watch" Enter

tmux attach -t work
```

## Key Detail

`Enter` at the end is literal — it sends the Return key. Without it, the command appears typed but never executes. You can send any key: `C-c` (Ctrl+C), `C-l` (clear), `Escape`, `Space`, etc.
