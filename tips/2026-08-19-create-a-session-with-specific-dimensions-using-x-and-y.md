# Create a session with specific dimensions using -x and -y

When launching a new tmux session, specify the initial width and height (columns and lines) directly instead of resizing afterward.

```bash
tmux new-session -s work -x 200 -y 50
```

This creates a session named `work` with 200 columns and 50 lines. Useful when you know exactly what size you need upfront, such as when automating session creation or matching a specific monitor layout.

Combine with other options:

```bash
tmux new-session -s project -x 180 -y 40 -c ~/code -d
```

This creates a detached session with 180 columns, 40 lines, in the `~/code` directory. The session immediately reflects your dimensions; no separate resize step needed.

Note: The server respects these dimensions when attaching; if your terminal is smaller than the requested size, tmux will constrain to what's available.
