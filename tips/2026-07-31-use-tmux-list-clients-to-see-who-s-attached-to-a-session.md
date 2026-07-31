# Use `tmux list-clients` to See Who's Attached to a Session

**Command:** `tmux list-clients -t <session-name>`

## Explanation

When multiple people (or multiple terminal windows on your own machine) are attached to the same tmux session, it's easy to lose track of who's connected, from which terminal, and with what window/pane focus. `list-clients` shows every client attached to a session, along with the terminal device, size, and last activity time. This is especially useful for pair-programming setups or shared debugging sessions where you want to confirm a teammate is actually connected before you start typing, or to figure out why a resize keeps happening (each attached client's terminal size affects the shared session).

## Example

Check who's attached to a session named `deploy`:

```
tmux list-clients -t deploy
```

Sample output:

```
/dev/ttys003: deploy [211x52 xterm-256color] (utf8)
/dev/ttys007: deploy [120x40 xterm-256color] (utf8)
```

Combine it with `tmux server-info` for a full picture, or pair it with `display-message -p '#{client_tty}'` inside a pane to identify which line in the list corresponds to your own terminal. If you need to boot a stale or duplicate client instead of just viewing it, follow up with:

```
tmux detach-client -t /dev/ttys007
```

This is a lighter-weight alternative to detaching *all* other clients when you only want to remove one specific connection.
