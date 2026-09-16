# Use Alt+key combinations in send-keys for readline navigation

**Shortcut:**
```
tmux send-keys -t pane-id M-f
```

**Explanation:**
While `Ctrl+key` combinations in `send-keys` are common, tmux also supports Alt (Meta) key bindings via the `M-` prefix. In readline (bash, zsh), Alt shortcuts move by word or perform quick edits without moving to the line start/end. This is useful for fixing commands in remote panes without manual cursor navigation.

**Examples:**

Jump forward one word in a partially-typed command:
```bash
tmux send-keys -t 0 M-f
```

Jump backward one word:
```bash
tmux send-keys -t 0 M-b
```

Delete word forward (kill-word):
```bash
tmux send-keys -t 0 M-d
```

Delete word backward:
```bash
tmux send-keys -t 0 'C-w'
```

Transpose two words:
```bash
tmux send-keys -t 0 'M-t'
```

**Practical workflow:**
Auto-fix a typo in a remote pane by jumping to the error and correcting it:
```bash
tmux send-keys -t worker 'M-b' Enter   # Jump back one word
tmux send-keys -t worker 'C-w'         # Delete the misspelled word
tmux send-keys -t worker 'correctword' # Type the fix
```
