# Periodically Snapshot Pane Output for Manual Log Rotation

**Command:** `tmux capture-pane -p -S -N >> logfile.txt`

**Explanation:** Capture the last N lines of scrollback and append to a log file without requiring persistent logging. Use this for selective logging, debugging snapshots, or lightweight recording of specific pane activity. The `-S` flag sets the scrollback range; `-p` prints to stdout.

**Quick Example:**

Create a binding to manually log the current pane's last 50 lines:

```tmux
bind-key L run "tmux capture-pane -t #{pane_id} -p -S -50 >> ~/pane-logs/#{session_name}_#{window_index}.log"
```

Snapshot every 10 seconds with:

```bash
while true; do
  tmux capture-pane -t mywindow:0 -p -S -30 >> debug.log
  sleep 10
done
```

Or capture just error lines from build output:

```bash
tmux capture-pane -t builder:0 -p | grep -i "error\|fail" >> errors.log
```

This is lighter than permanent pane logging—grab output on demand without cluttering your session with `remain-on-exit` configuration.
