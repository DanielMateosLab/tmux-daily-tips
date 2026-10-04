# Quickly Select a Session with choose-session

Interactively browse and attach to any session with a visual menu.

## Command

```
tmux choose-session
```

Or bind it for quick access:

```
bind s choose-session
```

## Explanation

`choose-session` displays a navigable list of all tmux sessions (running or not). Select one with arrow keys and press Enter to attach. Unlike `choose-tree` (which shows sessions, windows, and panes together), this command focuses only on sessions—cleaner when you have many sessions to choose from.

If you're already attached to a session and select another, tmux switches to it without detaching your current client.

## Example

```bash
# Bind to a key for quick access
bind-key -n C-s choose-session

# Now press Ctrl+s to open the session picker
# Use ↑/↓ to navigate, Enter to select, q to cancel
```

Session list preview:

```
(1) session-name-1       [80x24]
(2) session-name-2       [80x24]
(3) session-name-3       [80x24]
```

This is faster than `tmux attach -t session-name` when you forget the exact session name or have many sessions active.
