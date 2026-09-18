# Capture Pane Output Directly to a Buffer

**Command:** `capture-pane -b -t <target> -p <start-line>`

**Shortcut:** None (use in scripts or with `send-keys`)

Capture a pane's scrollback directly into a paste buffer instead of piping to stdout or a file. This is useful for saving output programmatically while keeping the original pane intact, then pasting or inspecting the buffer later.

The `-b` flag tells `capture-pane` to write to a buffer. By default it creates a new buffer, but you can target an existing one with the buffer name.

**Example:**

```tmux
# Capture last 50 lines from pane 0 into a new buffer
capture-pane -t :0 -b -S -50

# View the captured buffer
list-buffers

# Paste it into another pane
send-keys -t :1 C-b ]

# Or extract specific lines and save to a buffer
capture-pane -t :0 -b -S -100 -E -1
```

Use this to:
- Save test output without interrupting the pane
- Build a history of command outputs
- Quickly collect logs for inspection without external files
- Chain with `show-buffer` or `delete-buffer` to process captured output
