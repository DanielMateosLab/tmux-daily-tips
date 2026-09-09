# Join Wrapped Lines When Capturing Pane Output

**Command:** `capture-pane -J`

The `-J` flag joins lines that wrapped due to terminal width, so captured text flows naturally instead of breaking at terminal boundaries. Essential when piping pane output to `grep`, `awk`, or other tools that expect full lines.

**Example:**

Without `-J`, grep might miss matches broken across wraps:
```bash
tmux capture-pane -t 0 -p | grep "error" # misses lines that wrapped
```

With `-J`, full lines stay intact:
```bash
tmux capture-pane -t 0 -p -J | grep "error"  # catches wrapped lines
```

Extract and process logs correctly:
```bash
tmux capture-pane -t session:window -p -J -S -100 | \
  grep "ERROR\|WARN" > /tmp/recent-errors.log
```

Combine with `-e` to preserve ANSI colors while joining:
```bash
tmux capture-pane -t 0 -p -J -e > captured-output.txt
```

Use in scripts to reliably count or search pane output regardless of terminal width.
