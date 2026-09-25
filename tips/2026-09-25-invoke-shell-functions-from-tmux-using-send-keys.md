# Invoke Shell Functions from Tmux Using send-keys

Define shell functions in a pane, then call them from tmux to create reusable, multi-step workflows.

**Shortcut:** `send-keys -t pane 'function_name args' Enter`

**Why it's useful:**
- Keep complex command sequences in shell functions, not tmux config
- Reuse the same workflow from multiple panes
- Test and debug logic in the shell
- Combine with send-keys automation for hands-off task execution

**Example:**

Define a function in a pane's shell:

```bash
deploy() {
  git pull && npm test && npm run build && npm run deploy
}
```

Then invoke it from tmux (or another pane):

```bash
tmux send-keys -t production-pane 'deploy' Enter
```

With arguments:

```bash
serve_on_port() {
  cd "$1" && python -m http.server "$2"
}

tmux send-keys -t docs-pane 'serve_on_port ./public 8000' Enter
```

**Key tip:** The function must be defined in the pane's shell environment. Define them in dotfiles (`.bashrc`, `.zshrc`) or at the start of long-lived panes.

This approach keeps your tmux config simple and moves logic where it's easier to maintain and test — the shell itself.
