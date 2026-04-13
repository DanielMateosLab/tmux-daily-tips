

# Use `run-shell` to Execute Commands Without a Visible Pane

## The Command

```
run-shell [-b] [-d delay] [-C] [-t target-pane] shell-command
```

**Prefix shortcut:** None by default — typically bound manually or used in `tmux.conf`.

## What It Does

`run-shell` executes a shell command in the background within tmux's server process, displaying the output (if any) in the status line area. Unlike `send-keys` or `pipe-pane`, it doesn't require a target pane to run in — tmux itself runs the command and captures the result.

The `-b` flag makes it fully asynchronous (non-blocking), so tmux remains responsive while the command runs.

## Why It's Useful

- **Notifications:** Trigger desktop alerts from tmux events without dedicating a pane.
- **Dynamic configuration:** Update status bar elements, change options, or set environment variables based on external state.
- **Scripting glue:** Chain tmux commands with shell logic that would be awkward in pure tmux syntax.

## Practical Examples

### Show a desktop notification when a long build finishes

```bash
# In your shell, after kicking off a build:
make all; tmux run-shell 'osascript -e "display notification \"Build done\" with title \"tmux\""'
```

### Dynamically set a tmux option from a shell command

```tmux
# In tmux.conf — set status bar color based on hostname
run-shell 'case "$(hostname)" in \
  prod-*) tmux set -g status-style "bg=red,fg=white" ;; \
  stg-*)  tmux set -g status-style "bg=yellow,fg=black" ;; \
  *)      tmux set -g status-style "bg=green,fg=black" ;; \
esac'
```

### Bind a key to copy your current pane's working directory to the clipboard

```tmux
bind D run-shell 'tmux display-message -p "#{pane_current_path}" | pbcopy'
```

Press `Prefix + D` and the pane's working directory is silently copied to your system clipboard — no output, no pane needed.

### Run a background health-check every 30 seconds

```tmux
# In tmux.conf — non-blocking periodic check
set-hook -g periodic-30 'run-shell -b "curl -sf http://localhost:8080/health || tmux display-message \"Service DOWN\""'
```

This combines `set-hook` (periodic timer) with `run-shell -b` to poll a service without blocking any input.

## Key Flags

| Flag | Effect |
|------|--------|
| `-b` | Run in background (non-blocking) |
| `-d delay` | Wait *delay* seconds before executing |
| `-C` | Treat the command as a tmux command, not a shell command |

## Tips

- Output from `run-shell` appears briefly in the status line. Use `display-message` inside the command for more controlled output.
- Combine `-b` and `-d` to schedule deferred actions: `run-shell -b -d 5 'tmux kill-pane -t 3'` kills pane 3 after a 5-second delay.
- Use `-C` to run tmux commands that need shell-computed arguments: `run-shell -C 'rename-window "#{pane_current_command}"'`.
