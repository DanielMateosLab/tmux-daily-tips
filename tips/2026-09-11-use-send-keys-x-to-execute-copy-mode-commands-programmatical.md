# Use send-keys -X to execute copy-mode commands programmatically

## Shortcut

```tmux
send-keys -X <copy-mode-command> [arguments]
```

## Explanation

The `-X` flag allows you to execute copy-mode commands (like searching, selecting, or copying) without manually entering copy-mode. This is powerful for automation: you can jump to text, select it, and copy it all from a single tmux command.

Common copy-mode commands:
- `search-forward <pattern>` — find text moving downward
- `search-backward <pattern>` — find text moving upward
- `copy-selection` — copy selected text
- `select-word` — select the word at cursor
- `start-of-line` / `end-of-line` — move to line boundaries

## Examples

Search for "ERROR" in the current pane and copy the first match:

```bash
tmux send-keys -X search-forward "ERROR"
tmux send-keys -X copy-selection
```

Jump to a function name in a log file:

```bash
tmux send-keys -X search-forward "function_name"
```

Quickly select and capture the last 10 lines of output:

```bash
tmux send-keys -X end-of-line
tmux send-keys -X copy-selection
```

Use in a script to extract error messages from pane history:

```bash
tmux send-keys -X search-forward "Exception"
tmux capture-pane -p  # Print pane with selection highlighted
```
