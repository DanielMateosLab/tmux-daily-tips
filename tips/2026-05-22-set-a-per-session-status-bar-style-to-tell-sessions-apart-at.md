# Set a Per-Session Status Bar Style to Tell Sessions Apart at a Glance

## Command

```
tmux set-option status-style "bg=colour22,fg=white"
```

Or, scoped explicitly to the current session:

```
tmux set-option -t mysession status-style "bg=colour52,fg=white"
```

## Explanation

`status-style` controls the colors of the tmux status bar. Because options can be set per-session (the default for `set-option` without `-g`), you can give each session its own distinctive status bar color. This is invaluable when you juggle multiple sessions — for example, one for production work, one for staging, and one for personal experiments. A glance at the color tells you exactly where you are, reducing the risk of running the wrong command in the wrong environment.

Pair it with `window-status-current-style` for even sharper visual separation, and combine with `set-hook` to apply colors automatically when sessions are created.

## Example

Create two sessions with distinct status bars:

```bash
# Production session — red bar as a warning
tmux new-session -d -s prod
tmux set-option -t prod status-style "bg=colour52,fg=white,bold"

# Development session — green bar, safe to experiment
tmux new-session -d -s dev
tmux set-option -t dev status-style "bg=colour22,fg=white"
```

Now `tmux attach -t prod` shows a red bar, while `tmux attach -t dev` shows a green one. You'll never confuse the two again.

To automate it, add a hook in `~/.tmux.conf` that colors any session whose name starts with `prod-`:

```tmux
set-hook -g session-created 'if -F "#{m:prod-*,#{session_name}}" \
  "set-option status-style bg=colour52,fg=white,bold"'
```

Verify the current setting any time with:

```
tmux show-options -v status-style
```
