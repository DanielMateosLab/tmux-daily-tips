# Send a sequence of commands with timing control to multiple panes

Use `send-keys` in a loop with `sleep` between commands when you need to execute steps sequentially across panes—useful for testing workflows, staged deployments, or any interactive scenario where commands must complete before the next one starts.

## The pattern

```bash
for cmd in 'make build' 'make test' 'make deploy'; do
  tmux send-keys -t session:window "$cmd" Enter
  sleep 1
done
```

Without delays, rapid `send-keys` calls queue before the shell finishes processing, causing commands to run together or get mangled. `sleep` lets each complete before sending the next.

## Example: deploy workflow

```bash
tmux new-session -d -s deploy -n app
for cmd in 'cd src' 'npm run build' 'npm run test' 'npm deploy'; do
  tmux send-keys -t deploy:app "$cmd" Enter
  sleep 2
done
```

## Send the same command to all panes with stagger

```bash
for pane in $(tmux list-panes -t mywindow -F '#{pane_id}'); do
  tmux send-keys -t "$pane" 'echo Ready && sleep 2 && run-test' Enter
  sleep 0.5  # stagger starts
done
```

## Vary delays per command

```bash
cmds=('slow-setup:5' 'quick-check:1' 'final-step:3')
for item in "${cmds[@]}"; do
  cmd="${item%:*}"
  delay="${item#*:}"
  tmux send-keys -t sess "$cmd" Enter
  sleep "$delay"
done
```

Each pane processes its command fully before the next arrives, giving you predictable, debuggable execution order across tmux sessions.
