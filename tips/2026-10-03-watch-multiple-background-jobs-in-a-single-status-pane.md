# Watch multiple background jobs in a single status pane

**Shortcut**: `send-keys` + `capture-pane` + shell loop

When you're managing several long-running processes (tests, builds, deployments), create a dedicated pane that polls and displays the status of each without leaving your main workspace.

## The command

Create a pane that continuously monitors processes:

```tmux
bind-key C-d run-shell "tmux new-window -n status -c #{pane_current_path} && tmux send-keys -t status 'while true; do clear; echo \"=== Status Pane ===\"; pgrep -fl \"(npm test|cargo build|docker)\" || echo \"No jobs running\"; sleep 2; done' Enter"
```

Or simpler—just a keybinding to launch a monitoring shell:

```tmux
bind-key S-d split-window -h -l 30 "watch -n 1 'echo Running jobs:; pgrep -fl npm || echo None'"
```

## Why this helps

Instead of switching panes to check if a build finished, glance at your status pane on the side. It updates every 2 seconds without stealing focus. Stack multiple `pgrep` or `ps` commands to track exactly what you care about—test suites, servers, compilers, containers.

## Example

```
C-b S-d        # split-window with watch command
                 ┌─ Main pane ─────────┬─ Status (30 cols) ─────┐
                 │ $ dev server running │ Running jobs:          │
                 │ > Listening on :3000 │ 1234 npm test          │
                 │                      │ 5678 cargo build       │
                 │                      │ (updates every 2 sec)  │
                 └──────────────────────┴────────────────────────┘
```

Pair with `setw -t status remain-on-exit on` to keep the window alive even after the command exits.
