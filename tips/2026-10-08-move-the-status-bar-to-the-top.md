# Move the Status Bar to the Top

By default, tmux displays the status bar at the bottom of your terminal. Moving it to the top keeps it visible while scrolling and uses your screen real estate more efficiently.

**Shortcut:**

```
set -g status-position top
```

**How it works:**

The `status-position` option controls whether your status bar appears at `top` or `bottom` (the default). Setting it to `top` moves the status line above all your panes, keeping it in view without interfering with your output.

**Practical example:**

Add this line to `~/.tmux.conf`:

```
set -g status-position top
```

Reload your config with:

```
tmux source-file ~/.tmux.conf
```

Or from within tmux, press your prefix and type:

```
: set -g status-position top
```

**Why use this:**

- Status bar stays visible when scrolling through long output
- Reduces eye movement between your command area and status info
- Better use of vertical space on modern displays
- Preferred by users coming from screen or other multiplexers

**Toggle it on the fly:**

Bind a key to quickly switch between positions:

```
bind-key T run-shell "tmux show-options -g status-position | grep -q top && tmux set -g status-position bottom || tmux set -g status-position top"
```
