# Send Literal Text, Character by Character, with send-keys -l

## The Command

```
send-keys -l "text to send"
```

## Why It's Useful

The `-l` flag sends each character literally, one at a time, preventing tmux and the shell from interpreting special characters like `$`, backticks, braces, and metacharacters. Use this when sending code snippets, variable references, or syntax that the shell shouldn't expand.

## Example

**Without `-l`** (shell expands `$HOME`):
```
tmux send-keys 'echo $HOME'  # Outputs your home directory
```

**With `-l`** (sends literal text):
```
tmux send-keys -l 'echo $HOME'  # Outputs: echo $HOME
```

**Practical example:** Send a Python f-string to a remote pane with braces preserved:
```
tmux send-keys -l 'name = "Alice"; print(f"Hello, {name}!")' Enter
```

This sends the exact syntax, allowing Python (not the shell) to interpret the f-string.

**Another use case:** Send regex patterns to grep without shell globbing:
```
tmux send-keys -l 'grep "^[0-9]\{3\}$" file.txt' Enter
```

The literal flag keeps your escape sequences intact.
