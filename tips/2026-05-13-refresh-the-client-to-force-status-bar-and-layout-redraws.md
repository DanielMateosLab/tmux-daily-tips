# Refresh the Client to Force Status Bar and Layout Redraws

**Command:** `tmux refresh-client` (or `<prefix> :refresh-client`)

When tmux's status bar shows stale content, the screen looks garbled after resizing a terminal emulator, or a format variable in your status line isn't updating, `refresh-client` forces tmux to redraw everything for the attached client without disturbing your panes or running processes.

## Useful Flags

- `-S` — redraw **only** the status line (cheap, instant)
- `-c` — clear any overlay (like `display-popup` or `display-menu`)
- `-l` — request the terminal's foreground/background colors again (handy after switching terminal themes)
- `-t <client>` — target a specific client
- `-C <width>x<height>` — set the client size manually (useful for headless control-mode clients)

## Example: Bind a Key to Force-Refresh

Drop this in `~/.tmux.conf` for a one-keystroke fix when the UI gets out of sync:

```tmux
bind R refresh-client -S \; display-message "status bar refreshed"
```

Now `<prefix> R` repaints the status line and confirms it in the message area.

## Example: Refresh After Updating a Status Variable

If your status bar shows a value pulled from a shell command via `#(...)`, tmux only re-runs it on the `status-interval`. To see changes immediately after editing a watched file:

```bash
# from outside tmux, or from any pane
tmux refresh-client -S
```

This is much lighter than `tmux source-file ~/.tmux.conf` when you just need a visual repaint, not a configuration reload.

## When to Reach for It

- Status bar shows yesterday's git branch after a `checkout`
- Terminal was resized over SSH and tmux didn't catch the new dimensions
- A popup or menu left visual artifacts behind
- You changed `status-left`/`status-right` and want to see it now, not in 15 seconds

Pair it with `set -g status-interval 5` for a status bar that's both responsive and manually refreshable.
