# Show a Confirmation Prompt Before Destructive Commands

**Command:** `confirm-before -p "prompt text" "command"`

Tmux can wrap any command in an interactive yes/no confirmation. This is perfect for guarding destructive actions like `kill-session`, `kill-window`, or custom scripts where a stray keypress could cost you work. The `-p` flag customizes the prompt, and `%%` inside the prompt expands to the command being confirmed.

By default, `prefix + &` (kill-window) and `prefix + x` (kill-pane) already use `confirm-before`, but you can apply it to anything.

## Example

Rebind `prefix + K` to kill the entire session, but only after confirming:

```tmux
bind K confirm-before -p "kill session #S? (y/n)" kill-session
```

Now pressing `prefix + K` shows in the status bar:

```
kill session my-project? (y/n)
```

Press `y` to confirm, `n` or `Esc` to cancel.

You can also wrap shell commands that have side effects:

```tmux
bind R confirm-before -p "reload tmux config? (y/n)" "source-file ~/.tmux.conf ; display 'reloaded'"
```

Or guard a "kill all other windows" shortcut:

```tmux
bind o confirm-before -p "kill all other windows? (y/n)" "kill-window -a"
```

## Tip

Combine with format variables in the prompt for context-aware messages:

```tmux
bind X confirm-before -p "kill pane #P in window #W? (y/n)" kill-pane
```

The prompt will render the actual pane and window names before you commit — a small habit that saves you from the occasional "wait, wrong session" disaster.
