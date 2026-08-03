# Build Commands Interactively with send-keys -H

**Shortcut:** `tmux send-keys -t <target> -H "command text"`

**What it does:**
The `-H` flag sends text to a pane character-by-character without pressing Enter, allowing the user to see and edit the command before execution. Perfect for automation where you want human review before running something destructive or important.

**Example:**
```bash
# From a script or binding, build a command for the user to review
tmux send-keys -t myapp:build -H "docker build --no-cache -t myapp:latest ."

# User sees the command in the pane, can edit it, then press Enter when ready
```

**Practical use case:**
Create a keybinding that pre-fills a complex or risky command, letting the user tweak arguments before committing:

```tmux
bind-key C-d send-keys -t work:1 -H "rm -rf ./build && make clean"
```

Press the binding, review the command, adjust the target directory if needed, then press Enter. Beats typing it from scratch.
