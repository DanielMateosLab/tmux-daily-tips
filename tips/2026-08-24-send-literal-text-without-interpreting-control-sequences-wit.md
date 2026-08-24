# Send Literal Text Without Interpreting Control Sequences with send-keys -l

`send-keys -l` sends text character-by-character as literal characters, useful when you need to type strings that resemble key names or control sequences.

## Command

```
send-keys -l -t session:window.pane 'text to type literally'
```

## Explanation

By default, `send-keys` interprets sequences like `C-c`, `M-x`, and `Tab` as control characters. The `-l` flag treats everything as literal text—each character is typed as-is, without interpretation. This is essential when you need to type commands that contain what looks like keybindings but should appear as plain text.

## Example

Suppose you're scripting a Python REPL session and need to type the literal string `C-c` as a comment:

```bash
send-keys -l -t myrepl 'Exit with C-c'
send-keys -t myrepl 'Enter'
```

Without `-l`, tmux would interpret `C-c` as the interrupt signal instead of typing those characters.

## Another Use Case

Send a command line with variable-like text for inspection:

```bash
send-keys -l -t dev 'echo $SHELL'
send-keys -t dev 'Enter'
```

The literal text `$SHELL` is typed as-is; without `-l`, the shell might expand it first.

## Shortcut Comparison

- `send-keys 'command' 'Enter'` → interprets keybindings, sends two operations
- `send-keys -l 'command' 'Enter'` → types `command Enter` as literal text
- `send-keys 'command' 'C-m'` → types command, sends Ctrl+M

The `-l` flag is essential for demonstrating keybindings or editing shell scripts without triggering their effects.
