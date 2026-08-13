# Quickly tail logs with filtered output using send-keys and shell pipes

**Shortcut/Command:**
```
send-keys "tail -f /var/log/app.log | grep -E 'ERROR|WARN'" Enter
```

**Explanation:**

Use `send-keys` to inject a pre-built log-tailing command with filtering directly into any pane. This is faster than manually typing the command and lets you bind it to a key for instant access. By combining `tail -f` (follow file) with pipes and `grep`, you can monitor only the logs you care about. The `Enter` at the end executes it immediately.

**Concrete Example:**

Add this to your tmux config to bind `Ctrl-l` to open a log tail in your current pane:

```
bind-key C-l send-keys "tail -f /var/log/myapp.log | grep -v DEBUG" Enter
```

For a more sophisticated setup, create a dedicated log pane:

```
bind-key C-l new-window -n logs \; \
  send-keys "tail -f /var/log/app.log | grep 'ERROR'" Enter \; \
  split-window -v \; \
  send-keys "tail -f /var/log/other.log" Enter
```

This creates a new window with two panes: one filtering for errors, one showing all output. You can adapt the log paths and filters to your project's needs.
