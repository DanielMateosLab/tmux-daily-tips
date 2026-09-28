# Create a Live REPL Pane for Testing and Calculations

**Shortcut:** Use `send-keys -t` to feed commands into a dedicated interactive pane

Keep one pane running an interactive interpreter (Python, Node, bash, etc.) and send commands to it from anywhere in your session without switching focus. Each execution updates the pane in real-time.

## Setup

Create a window with a REPL pane:

```bash
tmux new-window -n repl "python3 -i"
```

## Usage

From any other pane, send commands to evaluate:

```bash
# From another pane or via keybinding
tmux send-keys -t repl "import json; print(json.dumps({'test': 1}))" Enter
tmux send-keys -t repl "2 + 2" Enter
tmux send-keys -t repl "len('hello')" Enter
```

## Practical Example

Bind a key to send the current line to your REPL:

```bash
bind-key -n C-e send-keys -t repl "$(tmux capture-pane -p -t '{last}' -S -1 | sed 's/^\s*//')" Enter
```

Or create a simple calculator:

```bash
# Bind C-= to evaluate math expressions
bind-key -n C-= command-prompt -p "Calculate: " "send-keys -t repl '%1' Enter"
```

## Why It's Useful

- **No context switching:** Keep your main editor/work pane focused
- **Quick tests:** Validate code snippets without breaking workflow
- **Persistent state:** Python/Node interpreter maintains variables across commands
- **Audit trail:** All executions visible in the REPL pane for reference

Works with any interactive shell, language REPL, or command-line tool.
