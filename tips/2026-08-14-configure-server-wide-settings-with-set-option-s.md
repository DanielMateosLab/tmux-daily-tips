# Configure Server-Wide Settings with set-option -s

**Command:** `tmux set-option -s option value`

The `-s` flag sets options that apply to the entire tmux server (not just the session or pane):

```bash
# Increase default terminal colors
tmux set-option -s default-terminal "screen-256color"

# Set the default shell for all new panes/windows in this server
tmux set-option -s default-shell /bin/zsh

# Adjust how long status messages stay visible
tmux set-option -s display-time 2000
```

Server-level options apply across all sessions and windows. Session-level (no flag) overrides server-level. Pane-level (`-p`) overrides everything.

Add to your `.tmux.conf` to persist across restarts:

```
set-option -s default-terminal "screen-256color"
set-option -s default-shell /bin/zsh
set-option -s display-time 2000
set-option -s buffer-limit 50
```

View current server settings:

```bash
tmux show-options -s
```

Useful for baseline configuration that affects the entire server, without needing to reconfigure each session individually.
