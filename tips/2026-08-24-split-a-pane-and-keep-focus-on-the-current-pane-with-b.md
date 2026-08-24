# Split a pane and keep focus on the current pane with -b

**Command:** `split-window -b`

**Explanation:**
By default, `split-window` creates a new pane and immediately switches focus to it. The `-b` flag keeps focus on the current pane, making it useful when you want to create splits without losing your place.

Combine with `-h` (horizontal/vertical split), `-p` (percentage), and `-c` (directory) for full control:
- `-h`: Split vertically (left/right)
- `-v`: Split horizontally (top/bottom) — default
- `-p 30`: Make the new pane 30% of the space
- `-c /path`: Open the new pane in a specific directory

**Example:**

Create a vertical split on the left side (30% width) without losing focus:
```bash
tmux split-window -b -h -p 30
```

Create a horizontal split below without moving focus:
```bash
tmux split-window -b -v -p 25 -c ~/projects
```

Bind it to a key for quick splits:
```
bind-key -n M-\\ split-window -b -h -p 30
```

This is ideal for sidebar panes (logs, status, quick reference) that you want visible but don't want to focus on immediately.
