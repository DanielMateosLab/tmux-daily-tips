# Use list-buffers to View and Manage Clipboard History

## Shortcut
```
tmux list-buffers
tmux show-buffer -b <index>
tmux delete-buffer -b <index>
```

## Explanation
tmux maintains a clipboard history of copied text in numbered paste buffers. `list-buffers` shows all buffers with their size and a preview. Each time you copy with the copy keybinding, the new text becomes buffer 0 and existing buffers shift down. Use `show-buffer` to inspect full content or `delete-buffer` to clear old clips and free memory.

## Example

View all stored buffers:
```
tmux list-buffers
```

Output:
```
0: 23 bytes: "deploy.sh content here"
1: 45 bytes: "previous session config"
2: 8 bytes: "old cmd"
```

Show the full content of buffer 1:
```
tmux show-buffer -b 1
```

Delete the old buffer 2:
```
tmux delete-buffer -b 2
```

Paste from a specific buffer without switching panes:
```
tmux paste-buffer -t work-pane -b 0
```

This approach is faster than `choose-buffer` when you need to inspect multiple buffers or manage clipboard accumulation in long sessions.
