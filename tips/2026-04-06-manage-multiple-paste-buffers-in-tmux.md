# Manage Multiple Paste Buffers in tmux

tmux maintains a **stack of paste buffers**, not just one. Every time you copy text in copy mode, it gets pushed onto this stack. You can list, preview, and paste from any buffer — not just the most recent one.

## Key Commands

| Action | Shortcut / Command |
|---|---|
| List all buffers | `prefix` + `#` |
| Choose buffer interactively | `tmux choose-buffer` |
| Paste most recent buffer | `prefix` + `]` |
| Paste a specific buffer | `tmux paste-buffer -b buffer_name` |
| Delete a buffer | `tmux delete-buffer -b buffer_name` |
| Set buffer content manually | `tmux set-buffer "some text"` |
| Show buffer content | `tmux show-buffer -b buffer_name` |

## How It Works

Each copy operation pushes a new buffer onto the stack. Buffers are named automatically (`buffer0000`, `buffer0001`, …) with the most recent at the top. When you press `prefix` + `]`, tmux pastes from the top of the stack — but you can reach any older buffer too.

## Interactive Buffer Picker

The most useful command is `choose-buffer`, which shows a preview of each buffer and lets you select one to paste:

```
tmux choose-buffer -Z
```

The `-Z` flag zooms the picker to fill the pane, giving you more room to preview long entries.

You can bind this to a key for quick access:

```bash
# In ~/.tmux.conf
bind-key B choose-buffer -Z
```

Now `prefix` + `B` opens a searchable buffer list.

## Practical Example: Collecting Snippets

Say you're reviewing logs across several panes and need to gather multiple pieces of information:

1. In pane 1, enter copy mode (`prefix` + `[`), select an error message, press `Enter` to copy
2. In pane 2, copy a stack trace the same way
3. In pane 3, copy a config value
4. Press `prefix` + `B` to open the buffer picker
5. Select any of the three copied items to paste exactly where you need it

## Load External Content Into a Buffer

You can also load file content or command output directly into the buffer stack:

```bash
# Load a file into a named buffer
tmux load-buffer -b snippets /tmp/notes.txt

# Load command output into a buffer
echo "deploy-id: abc123" | tmux load-buffer -

# Paste it
tmux paste-buffer
```

This is handy for injecting prepared text (tokens, config blocks, SQL queries) into any pane without touching the clipboard.
