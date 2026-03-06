# Link a Window from Another tmux Session

## Shortcut

```
tmux link-window -s <source-session>:<window> -t <target-session>
```

## What It Does

`link-window` lets you share a single window across multiple tmux sessions. The window appears in both sessions simultaneously — any input or output in one is reflected in the other in real time. This is different from `move-window`, which relocates the window entirely.

This is invaluable when you have a long-running process (like logs or a dev server) in one session that you want visible in another without duplicating it.

## Example

Say you have a session called `backend` with a window running `tail -f` on your application logs at window index 2. You're now working in a session called `frontend` and want those logs accessible:

```bash
# Link window 2 from "backend" into the current session "frontend"
tmux link-window -s backend:2 -t frontend
```

The log window now appears as the next available index in `frontend`. Edit in either session and both reflect the same state.

## Unlinking

When you no longer need the shared window in the target session, unlink it without killing the original:

```bash
tmux unlink-window -t frontend:3
```

This removes the window from `frontend` but leaves it intact in `backend`. If you used `kill-window` instead, it would destroy the window in both sessions.

## Practical Workflow

```bash
# Session 1: start a dev server
tmux new-session -d -s dev
tmux send-keys -t dev "npm run dev" Enter

# Session 2: working on tests, but want the dev server visible
tmux new-session -d -s tests
tmux link-window -s dev:0 -t tests

# Attach to tests — you now see both your test workspace and the dev server
tmux attach -t tests
```

## Key Flags

| Flag | Purpose |
|------|---------|
| `-s` | Source session and window (`session:window`) |
| `-t` | Target session (and optional window index) |
| `-a` | Add after the current window in the target |
| `-k` | Replace an existing window at the target index |
