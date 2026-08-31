# Quick client switching with choose-client

When multiple clients are attached to the same tmux session, use `choose-client` to quickly jump between them without detaching.

**Shortcut:**
```
<prefix>:choose-client
```

Or bind it for direct access:
```
bind-key C-c choose-client
```

**How it works:**
`choose-client` displays an interactive list of all clients connected to the current session. Select one to switch your view to that client's perspective—useful in pair programming or when managing the same session from multiple terminals.

**Example:**
You're sharing a session with a teammate. Your client shows one window position, theirs shows another. Press `<prefix> C-c`, select their client, and your session snaps to their view, preserving their scroll position and window focus. Switch back anytime.

**Bonus:**
Filter the list by typing to find a specific client, or use `-t <target>` to choose from a specific session:
```
tmux choose-client -t myproject
```
