# Create Hidden Background Windows for Build Jobs or Monitoring

**Shortcut:** `new-window -d -c /path` with window names

**Explanation:** Create hidden background windows using `-d` (detached) and `-c` (start directory) to run long-running jobs like builds, tests, or log monitors without interrupting your active work. You can check on them anytime without switching away.

**Example:**

```bash
# Create a detached window that runs tests in the background
tmux new-window -t myproject -d -n tests -c ~/myproject "npm test"

# Create another for log monitoring
tmux new-window -t myproject -d -n logs -c ~/myproject "tail -f logs/app.log"

# Jump to the tests window anytime
tmux select-window -t myproject:tests

# Or send a command to the logs window without switching
tmux send-keys -t myproject:logs "clear" Enter
```

**Workflow:** Bind a key to quickly spawn background workers:

```bash
bind-key B new-window -d -c "#{pane_current_path}" -n bg
```

Now `<prefix>B` creates a hidden window in the current directory. Build jobs run silently while you stay focused. Use `list-windows` or `choose-window` to jump to results whenever ready.
