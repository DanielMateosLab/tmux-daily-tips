# View Any Pane's Output Without Switching Focus

**Command**: `tmux capture-pane -t pane-id -p`

Often you're focused on one pane but need to check the output of another pane without losing context or interrupting what you're doing. Instead of selecting that pane and breaking your workflow, capture its content directly.

The `-t` flag targets a specific pane, and `-p` prints the output to stdout (or your tmux command line). You can use `pane-id` in several formats: `session:window.pane`, `window.pane`, or just the pane index if in the current window.

## Example

Monitor a background build or test run while continuing to work in another pane:

```
tmux capture-pane -t 1.2 -p
```

This shows you everything currently visible in window `1`, pane `2`—without switching to it. Combine with `tail -10` to see just the last few lines:

```
tmux capture-pane -t build:logs.0 -p | tail -10
```

Great for watching long-running processes, checking error logs, or verifying that a background process is still alive—all from your current pane.
