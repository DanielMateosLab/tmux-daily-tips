# Add Sent Commands to Shell History with send-keys -H

**Command:**
```
send-keys -H "command"
```

**Explanation:**

By default, commands sent with `send-keys` don't appear in your shell's command history. The `-H` flag adds the command to the shell's history as if you typed it manually. This makes sent commands available for recall via `Ctrl-R` (reverse history search) and keeps your workflow traceable.

Without `-H`, automated commands vanish from history. With it, you can search and re-run them like any other command.

**Example:**

Create a keybinding that sends a deploy command and records it in history:

```tmux
bind-key D send-keys -H "git push origin main && ./deploy.sh" Enter
```

Now when you press `Ctrl-b D`, the deploy command runs and appears in history. Later, you can `Ctrl-R` to find and re-run it without retyping.

**Practical use case:**

Use this in scripted panes or automation workflows where you want full auditability. Especially useful for:
- Sending frequent commands (builds, deployments, tests)
- Creating audit trails of operations
- Making automation discoverable in shell history

**Tip:** Combine with `send-keys -C` to run without entering, or add `Enter` explicitly to execute immediately.
