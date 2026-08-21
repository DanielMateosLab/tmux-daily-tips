# Attach Directly to a Specific Pane by Address

**Command:** `tmux attach-session -t session:window.pane`

When attaching to a session, tmux focuses the first window by default. Use the full pane address syntax to jump straight to a specific pane without manual navigation: `session:window.pane`, where window is a number or name and pane is a pane number.

This is invaluable when you know exactly which pane you need—particularly useful in scripts and shell aliases for context-specific workflows.

**Example:**

```
# Jump directly to pane 1 in the logs window
tmux attach-session -t mywork:logs.1

# Abbreviate if the window name is unambiguous
tmux attach-session -t mywork:logs
```

Create aliases for frequently visited panes:

```bash
alias editor='tmux attach-session -t mywork:editor.0'
alias build='tmux attach-session -t mywork:build.1'
```

Now `editor` and `build` take you straight to those panes, even from a detached state or another session.

You can also use this syntax with other tmux commands like `send-keys -t session:window.pane` or `capture-pane -t session:window.pane` to operate on panes without switching focus.
