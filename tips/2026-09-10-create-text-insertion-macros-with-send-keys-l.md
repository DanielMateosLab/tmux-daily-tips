# Create Text-Insertion Macros with send-keys -l

Bind a key to insert literal text without shell interpretation or expansion, perfect for long commands you type frequently.

## Command

```tmux
bind-key M send-keys -l 'my-command --flag value' Enter
```

Press the key, and the exact text is typed character-by-character into the current pane.

## Why This Matters

- No shell expansion (variables, command substitution, backticks won't interpret)
- No special character escaping needed
- Safe for passwords, file paths, or complex command syntax
- Faster than typing and less error-prone

## Examples

Bind `Ctrl-M` to insert a Docker logs command:

```tmux
bind-key C-m send-keys -l 'docker logs --follow my-container' Enter
```

Bind `Ctrl-P` for a frequently-used psql connection:

```tmux
bind-key C-p send-keys -l 'psql -h localhost -U admin -d prod_db' Enter
```

Bind `Ctrl-G` to insert a git command with complex flags:

```tmux
bind-key C-g send-keys -l 'git log --oneline --graph --all' Enter
```

When you press the binding, the command appears in the pane exactly as written—no variables expanded, no glob patterns expanded—ready to run with Enter. Use `-l` instead of `-c` or `-N` to guarantee literal text.
