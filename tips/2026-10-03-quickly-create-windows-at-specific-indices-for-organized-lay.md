# Quickly Create Windows at Specific Indices for Organized Layouts

**Command:**
```
tmux new-window -t session:99
```

**What it does:**
Instead of creating a new window at the next available index, you can specify exactly where it appears in your window list using `-t session:INDEX`. This lets you organize related windows into semantic groups within a single session.

**Why it's useful:**
As sessions grow, managing window order becomes chaotic. By assigning windows to specific indices (0–9 for quick numbering, or higher for grouping), you create predictable layouts that don't shift when you add or remove windows.

**Practical workflow:**

```bash
# Set up a development session with intentional gaps
tmux new-session -d -s dev -n "editor"       # Window 0
tmux new-window -t dev:1 -n "test"          # Window 1
tmux new-window -t dev:2 -n "server"        # Window 2
tmux new-window -t dev:9 -n "notes"         # Window 9 (scratch space)

# Jump to specific windows by index
tmux select-window -t dev:0  # Back to editor
tmux select-window -t dev:9  # Quick notes window

# Your muscle memory maps to fixed positions
# Add new windows anywhere without disrupting the layout
tmux new-window -t dev:5 -n "db"            # Insert in the middle
```

**Tip:** Combine with `base-index 0` in your config, then use 0–4 for main work, 5–8 for utilities, and 9 for scratchpad.
