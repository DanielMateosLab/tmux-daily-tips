# Share Windows Between Sessions with Session Groups

## The Problem

You want two terminals to view the same tmux session, but each should be able to look at a **different window** independently. Attaching the same session twice forces both terminals to show the same window.

## The Solution

Create a **session group** with `new-session -t`. Grouped sessions share all windows, but each session's "current window" is independent.

## Command

```
tmux new-session -t original_session -s grouped_session
```

This creates `grouped_session` linked to `original_session`. Both sessions see the same set of windows, but you can switch windows in one without affecting the other.

## Shortcut from inside tmux

```
Prefix :  →  new-session -t my_session -s my_session_view2
```

## Practical Example

**Terminal 1** — start a session and open two windows:

```bash
tmux new-session -s work
# (creates window 0 — e.g., your editor)
# Prefix c  →  creates window 1 — e.g., a dev server
```

**Terminal 2** — create a grouped session:

```bash
tmux new-session -t work -s work-alt
```

Now in Terminal 1 you can stay on window 0 (editor) while Terminal 2 views window 1 (dev server). Creating or closing a window in either session is reflected in both.

## Why Not Just Attach Twice?

With `tmux attach -t work` in both terminals, switching windows in one terminal switches it in the other — they're locked together. Session groups break that coupling while keeping the windows shared.

## Cleanup

When you kill the grouped session, the windows survive in the original session:

```bash
tmux kill-session -t work-alt
```

Killing the **original** session destroys all shared windows and the grouped session too — so keep the primary session alive.

## Quick Reference

| Action | Command |
|---|---|
| Create grouped session | `new-session -t source -s name` |
| List sessions (see groups) | `tmux ls` |
| Kill only the grouped view | `kill-session -t name` |
