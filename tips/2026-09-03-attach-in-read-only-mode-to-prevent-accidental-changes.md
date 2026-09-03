# Attach in Read-Only Mode to Prevent Accidental Changes

**Shortcut:** `tmux attach-session -r` (or `tmux attach -r`)

When you connect to a tmux session from a shared terminal or want to monitor activity without risking accidental input, use the `-r` flag to attach in read-only mode. This prevents any keyboard or mouse input from affecting the session—you can see everything happening in real time but can't type commands or navigate panes.

## Example

```bash
tmux attach -r -t myworkspace
```

Useful for:
- Watching a colleague's session during pair debugging without fumbling the keyboard
- Monitoring long-running processes from a shared terminal
- Teaching or demonstrating without the audience accidentally disrupting the session
- Auditing or reviewing pane activity without risk of interference

To exit read-only mode and regain control, detach and re-attach without `-r`:

```bash
tmux attach -t myworkspace
```

If you're already attached in read-only and want to switch to read-write, detach from that client and attach normally. (Use `tmux list-clients -t sessionname` to see all connected clients.)
