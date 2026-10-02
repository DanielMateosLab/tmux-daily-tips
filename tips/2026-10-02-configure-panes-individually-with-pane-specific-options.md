# Configure Panes Individually with Pane-Specific Options

Tmux options cascade from global → session → window → pane. Use `-p` to override for individual panes.

**Set pane-specific option:**
```bash
set-option -p -t session:window.pane option value
set-option -p -t mywork:1.0 mode-keys vi
```

**View pane-specific option:**
```bash
show-options -p -t session:window.pane
```

**Useful pane options to override:**
- `mode-keys` — vi vs emacs bindings per pane
- `mouse` — enable/disable mouse in specific panes (read-only pane)
- `pane-border-status` — show status in pane borders individually

**Practical example: read-only monitoring pane**

Make a log-tailing pane read-only by disabling mouse interaction and setting vi mode:

```bash
# Create pane for logs
tmux split-window -h -t mywork 'tail -f app.log'

# Get the pane ID (e.g., mywork:0.1)
tmux send-keys -t mywork:0.1 C-c   # Stop any editing

# Disable mouse in just this pane
set-option -p -t mywork:0.1 mouse off

# Force vi mode for searching logs
set-option -p -t mywork:0.1 mode-keys vi
```

Now that pane is locked to vi copy-mode for searching, but your other panes remain unaffected. Pane options always override session and window settings.
