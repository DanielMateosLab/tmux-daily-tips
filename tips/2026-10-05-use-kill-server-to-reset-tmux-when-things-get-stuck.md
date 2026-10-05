# Use kill-server to Reset tmux When Things Get Stuck

**Shortcut/Command:** `tmux kill-server`

## Explanation

When tmux gets into a weird state — unresponsive keybindings, display glitches, orphaned sessions, or broken socket files — a full server reset can be more effective than killing individual sessions. This command terminates the entire tmux server and all sessions attached to it.

## Warning

This disconnects all clients and ends all sessions, so only use when you have no open work or have saved state elsewhere.

## Practical Example

If tmux is hanging or misbehaving:

```bash
tmux kill-server
tmux new-session -s main
```

This wipes the server completely and creates a fresh session. Faster than troubleshooting socket or permission issues.

**Pro tip:** If you need to clear the cache but keep one session, individually kill sessions with `tmux kill-session -t session-name` instead. But when the whole server is wedged, `kill-server` is the nuclear option that always works.
