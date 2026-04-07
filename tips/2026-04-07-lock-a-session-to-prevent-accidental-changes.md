

# Lock a Session to Prevent Accidental Changes

## The Command

```
tmux switch-client -r
```

Or from within tmux, press `prefix` then `:` and type `switch-client -r`.

## What It Does

The `-r` flag toggles the **read-only** flag on your current client. When a client is read-only, all key presses are ignored — you cannot type into panes, resize them, or trigger any keybindings (except detaching). The session itself keeps running normally; other non-read-only clients attached to the same session can still interact with it.

This is invaluable when:

- You're sharing a session with a colleague and want to be a **view-only observer**
- You want to **prevent accidental keystrokes** while monitoring long-running processes
- You're presenting or screen-sharing and don't want stray input ruining the demo

## Example: Pair Programming Observer Mode

Two developers attach to the same session. The observer locks their client:

```bash
# Developer A creates and works in the session
tmux new-session -s pairing

# Developer B attaches and immediately goes read-only
tmux attach -t pairing \; switch-client -r
```

Developer B can now watch everything Developer A does without any risk of interfering.

## Toggling Back

Run the same command again to unlock:

```
prefix : switch-client -r
```

The read-only state is per-client, not per-session, so other attached clients are unaffected.

## Binding It to a Key

Add this to your `~/.tmux.conf` for a quick toggle:

```tmux
bind-key R switch-client -r \; display-message "Read-only: #{?client_readonly,ON,OFF}"
```

Now `prefix R` toggles read-only mode and shows the current state in the status line.
