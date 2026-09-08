# Delete Specific Paste Buffers to Keep Your Clipboard Organized

## Shortcut / Command

```tmux
tmux delete-buffer -b buffer-name
```

## Explanation

Every time you copy text in tmux's copy mode, it goes into a paste buffer. Over time, you accumulate dozens of buffers. While `list-buffers` shows them all, you can't easily clean out buffers you no longer need. Use `delete-buffer -b` to remove a specific buffer by name, keeping your clipboard history manageable.

## Example

Assume `list-buffers` shows:
```
 0: 100 bytes: "foo bar"
 1: 50 bytes: "old command"
 2: 200 bytes: "important config"
```

Delete the old command buffer:
```tmux
tmux delete-buffer -b 1
```

Or bind a key to delete the current buffer:
```tmux
bind-key x run-shell "tmux delete-buffer -b #{buffer_index}"
```

Pair this with `list-buffers` (in copy mode with `=` or via keybinding) to interactively manage which buffers stay and which go.
