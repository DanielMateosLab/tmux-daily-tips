

# Use `remain-on-exit` to Keep Finished Panes for Inspection

When a command in a pane finishes (or crashes), tmux destroys the pane by default, taking all its output with it. The `remain-on-exit` option keeps dead panes open so you can read their final output, scroll through history, and then decide what to do.

## The Option

```
set -g remain-on-exit on
```

Or set it per-pane:

```
set -p remain-on-exit on
```

When enabled, a pane whose shell or command exits will display **Dead** in the status line instead of disappearing.

## Why This Is Useful

- **Debugging build scripts** — a compile or deploy that fails won't vanish before you can read the error
- **Running one-shot commands** — `tmux split-window -h 'curl -s https://example.com/api/health'` keeps the response visible after `curl` exits
- **Batch workflows** — launch several panes with different tasks and review results at your leisure

## Working With Dead Panes

Once a pane is dead, you can still scroll its output with copy mode (`prefix` + `[`).

When you're done inspecting, you have two choices:

**Restart the pane with the same command:**

```
respawn-pane
```

**Restart with a different command:**

```
respawn-pane 'make test'
```

**Kill the dead pane for good:**

```
kill-pane
```

## Practical Example

Launch three parallel build jobs and inspect their results afterward:

```bash
# Create a window with three panes, each running a build
tmux new-window -n builds
tmux set -w remain-on-exit on
tmux send-keys 'cd frontend && npm run build' Enter
tmux split-window -h 'cd backend && cargo build --release 2>&1'
tmux split-window -v 'cd docs && mkdocs build 2>&1'
```

All three panes stay visible after their commands finish. Scroll through any pane to check for warnings, then `respawn-pane` the ones you need to re-run.

## Scoping It Narrowly

If you only want this for specific panes rather than globally:

```bash
# Launch a pane that will persist after exit
tmux split-window -h -e REMAIN=1 'pytest -x tests/'
tmux set -p -t '{last}' remain-on-exit on
```

This keeps `remain-on-exit` off for your regular shell panes while preserving output for the specific commands you care about.
