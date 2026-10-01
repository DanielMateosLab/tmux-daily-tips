# Use send-keys to Control Interactive Debuggers from Another Pane

**Shortcut**: `send-keys -t <target-pane>` to inject debugger commands

**Explanation**: Automate debugging sessions by sending debugger commands (gdb, pdb, node inspect, lldb) from a separate control pane, eliminating focus-switching during interactive debugging.

**Example**:

```tmux
# Start gdb in one pane
tmux new-window -n gdb -c ~/myproject

# Create a control pane in a split
tmux split-window -t gdb -h

# Send debugger commands from the control pane
tmux send-keys -t gdb:0 "break main" Enter
tmux send-keys -t gdb:0 "run" Enter
tmux send-keys -t gdb:0 "next" Enter
tmux send-keys -t gdb:0 "print variable_name" Enter

# Or bind keys for quick access
bind -n M-b send-keys -t gdb:0 "break " \; send-keys -t gdb:1 "focus debug"
bind -n M-c send-keys -t gdb:0 "continue" Enter
bind -n M-n send-keys -t gdb:0 "next" Enter
```

This workflow lets you maintain focus in an editor or code pane while controlling a debugger session in another pane, without constantly switching windows. Useful for Python (pdb), Node.js (node inspect), C/C++ (gdb), or Rust (rust-gdb).
