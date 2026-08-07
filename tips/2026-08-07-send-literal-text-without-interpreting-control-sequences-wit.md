# Send Literal Text Without Interpreting Control Sequences with -l

**Command:**
```
send-keys -t pane -l "your literal text here"
```

**Explanation:**
By default, `send-keys` interprets special sequences like `C-c`, `Enter`, and `M-x` as control characters. The `-l` flag sends the string literally, treating every character as-is without interpretation. This is essential when you need to paste raw text that might contain sequences that look like control codes but should be literal.

**Example:**

Send actual text "C-c is great" without triggering Ctrl-C:
```
tmux send-keys -t pane -l "C-c is great"
```

Without `-l`, this would terminate the pane with Ctrl-C instead.

Paste a JSON string with special chars:
```
tmux send-keys -t work:1 -l '{"key": "M-x value"}'
```

This sends the literal string `{"key": "M-x value"}` instead of trying to execute Alt-x.

Paste a config file snippet:
```
tmux send-keys -t editor -l "set statusline=%F  (looks like a vim command but sends literally)"
```

Use `-l` whenever copying files, config snippets, code, or any content that might accidentally contain sequences that tmux would interpret as commands.
