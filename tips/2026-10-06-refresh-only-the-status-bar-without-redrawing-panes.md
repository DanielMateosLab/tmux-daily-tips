# Refresh Only the Status Bar Without Redrawing Panes

**Command**: `refresh-client -S`

**Explanation**: By default, `refresh-client` redraws the entire tmux client, including all panes. The `-S` flag updates only the status bar, avoiding flicker and improving performance when you're updating status information dynamically via hooks, scripts, or format changes.

**Example**:
```
# Add to config to keep status bar fresh after events
set-hook -g session-created 'refresh-client -S'

# Or after updating status-left dynamically
tmux set-option -t mysession status-left '#(date +%H:%M)' \; refresh-client -S
```

This is essential when you have frequently-changing status bar content (live clock, git branch, CPU usage) — full redraws cause pane flicker, but `-S` keeps panes stable while updating the bar smoothly.
