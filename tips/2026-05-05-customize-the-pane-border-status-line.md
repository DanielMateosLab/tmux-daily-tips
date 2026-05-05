# Customize the Pane Border Status Line

Tmux can render a status line on each pane's border, displaying live information like the running command, working directory, or custom text — perfect for keeping track of what's happening in busy layouts.

## The options

```tmux
set -g pane-border-status top      # or 'bottom' / 'off'
set -g pane-border-format " #P: #{pane_current_command} (#{b:pane_current_path}) "
```

- `pane-border-status` — where to draw the border line: `top`, `bottom`, or `off`
- `pane-border-format` — the format string, with the same `#{...}` variables you'd use in the status bar

## Why it's useful

When a window has three or four panes, it's easy to lose track of which one is running the dev server, which is tailing logs, and which is your editor. A border label gives every pane a permanent, glanceable identity without burning a status-bar slot or stealing screen real estate.

## Concrete example

Add this to `~/.tmux.conf`:

```tmux
set -g pane-border-status top
set -g pane-border-format "#{?pane_active,#[fg=green bold],#[fg=white]} #P  #{pane_current_command}  #[fg=cyan]#{b:pane_current_path} "
```

Reload with `prefix + :` then `source-file ~/.tmux.conf`.

Now each pane shows something like:

```
─ 1  vim  ~/project/src ──────────────────
─ 2  npm  ~/project ──────────────────────
─ 3  zsh  ~/project/logs ─────────────────
```

The active pane gets a bold green label so it stands out at a glance.

## Toggle it on demand

Bind a key to flip the border on and off when you need more vertical space:

```tmux
bind B set -g pane-border-status \
  "#{?#{==:#{pane-border-status},top},off,top}" \; \
  display-message "border: #{pane-border-status}"
```

Now `prefix + B` toggles the per-pane labels whenever they get in the way.
