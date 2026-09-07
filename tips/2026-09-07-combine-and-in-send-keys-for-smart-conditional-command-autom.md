# Combine && and || in send-keys for smart conditional command automation

## Shortcut / Command

```
tmux send-keys -t pane 'cmd1 && cmd2 || fallback' C-m
```

## Explanation

When using `send-keys` to automate commands in panes, chain commands with shell operators (`&&` for success, `||` for failure) to create robust workflows that adapt to real outcomes. Unlike sending commands one at a time, this lets a single `send-keys` call execute an entire decision tree, reducing round-trips and keeping pane state deterministic.

The `&&` operator runs the next command only if the previous one succeeds (exit code 0). The `||` operator runs a fallback if the prior command fails. This is particularly useful for build pipelines, deployment checks, and error recovery in automated setups.

## Concrete Example

Set up a build-test-clean pipeline in a background pane:

```bash
# In your tmux config or script:
tmux new-window -t session -n build
tmux send-keys -t session:build \
  'cd ~/project && npm run build && npm test || npm run clean' C-m
```

Or interactively from another pane:

```bash
tmux send-keys -t work 'cargo build --release && cargo test || echo "Build failed, skipping tests"' C-m
```

The entire chain runs without intervention. If the build fails, the tests don't run and the fallback message appears. If both succeed, you see test output.

**Why it matters:** Sending commands one at a time requires polling or watching logs to know when to send the next command. Chains execute atomically within the shell, so you can walk away and let the pane finish, or capture the final state reliably in a script.
