# Dynamically Set tmux Options Based on External Commands

**Shortcut:**
```
run-shell "tmux set-option -g @myvar $(shell-command)"
```

**Explanation:**
Capture external command output and store it in tmux variables using `run-shell`. This lets you set options, status bar content, or custom variables based on real-time data like git branches, SSH state, or system info.

**Example:**

Show current git branch in the status bar:

```
run-shell "tmux set-option -g @branch $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'main')"
set-option -g status-right "#[fg=cyan]#{@branch} #[fg=default]%H:%M"
```

Create a binding that detects SSH and sets a flag:

```
bind-key U run-shell "if [ -n \"$SSH_CLIENT\" ]; then tmux set-option -g @ssh on; else tmux set-option -g @ssh off; fi"
set-option -g status-left "#{?@ssh,#[fg=red][SSH],#[fg=green][LOCAL]} "
```

Or show the active Python virtualenv in your prompt:

```
run-shell "tmux set-option -g @venv $(python -c \"import sys; print(getattr(sys, 'real_prefix', None) and 'yes' or 'no')\" 2>/dev/null || echo 'no')"
```
