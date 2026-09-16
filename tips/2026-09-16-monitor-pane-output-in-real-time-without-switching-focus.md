# Monitor Pane Output in Real-Time Without Switching Focus

**Command:** `capture-pane -p -S -N`

**What it does:** Capture the last N lines of a pane's scrollback and print them raw, without moving focus or entering copy-mode. Useful for polling a pane's output periodically without disrupting your workflow.

**Example:** Create a monitoring loop that checks a background pane every 2 seconds:

```tmux
bind m run "while true; do tmux capture-pane -t:0.1 -p -S -30 | head -20; sleep 2; done"
```

Or set up a dedicated monitor window:

```tmux
new-window -n monitor
send-keys "while true; do tmux capture-pane -t:0.0 -p -S -100 -N; clear; sleep 1; done" Enter
```

**Flags explained:**
- `-p`: Print to stdout instead of copying
- `-S -N`: Show last N lines (e.g., `-S -30` shows 30 lines before the end)
- `-N`: Strip escape sequences (useful for clean output)
- `-J`: Join wrapped lines (if monitoring text that may wrap)

**Use cases:** Real-time log tailing, monitoring build output, watching long-running commands, or tracking test progress — all without losing focus in your main pane. Combine with `display-popup` for an overlay monitor.
