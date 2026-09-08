# Use send-keys -e to expand format strings when sending commands

**Command:** `send-keys -e "command with #{variable_name}"`

When you send complex commands to panes, format strings like `#{pane_path}`, `#{session_name}`, or `#{window_name}` are normally treated as literal text. The `-e` flag tells `send-keys` to expand these format strings first, letting you build dynamic, context-aware commands on the fly.

## Example

Suppose you want to quickly send a command that cd's to the current pane's working directory:

```
bind C-d send-keys -e "cd #{pane_path} && ls -la" Enter
```

Or create a command that opens a file in an editor using the session name:

```
send-keys -e "vim project_#{session_name}.log" Enter
```

Without `-e`, these strings would be pasted literally. With it, tmux substitutes the actual values before sending, so your commands adapt to context automatically.

This pairs well with scripts that orchestrate panes — you can build commands that reference the current session, window, or pane state without hardcoding values or parsing tmux output separately.
