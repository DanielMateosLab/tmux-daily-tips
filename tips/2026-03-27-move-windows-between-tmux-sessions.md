# Move Windows Between Tmux Sessions

## The Command

```
Prefix + . (move-window prompt)
tmux move-window -s <source> -t <target>
```

## What It Does

`move-window` detaches a window from one session and attaches it to another. This is invaluable when you realize a window belongs in a different project session, or when you want to consolidate work scattered across sessions.

Pressing `Prefix + .` brings up a prompt where you type the target session (and optional index) to move the current window there.

## Examples

**Interactive move (from inside tmux):**

Press `Prefix + .`, then type the destination:

```
# Move current window to session "backend"
backend:
# Move current window to index 3 in session "backend"
backend:3
```

**Command-line moves:**

```bash
# Move window 2 from session "dev" to session "staging"
tmux move-window -s dev:2 -t staging

# Move current window to session "ops" at index 0
tmux move-window -t ops:0

# Move and renumber: append to the end of the target session
tmux move-window -t ops:
```

**Swap windows between sessions:**

```bash
# Swap window 1 in "frontend" with window 3 in "backend"
tmux swap-window -s frontend:1 -t backend:3
```

## Practical Workflow

You're debugging in a `dev` session and realize your database monitoring window should live in your `ops` session:

```bash
# From the db-monitor window, move it to ops
tmux move-window -t ops:

# Or use the shortcut: Prefix + . → ops:
```

The window disappears from `dev` and appears in `ops`, preserving all running processes and pane layouts inside it.

## Useful Flags

| Flag | Purpose |
|------|---------|
| `-d` | Don't switch to the target session after moving |
| `-k` | Kill the target window if it already exists at that index |
| `-r` | Renumber remaining windows in the source session |

```bash
# Move without following, and renumber the source session
tmux move-window -dr -t ops:
```
