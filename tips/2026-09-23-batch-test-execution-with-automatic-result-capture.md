# Batch Test Execution with Automatic Result Capture

Run multiple commands in parallel panes and automatically capture output only when tests fail, saving logs for later review.

## Command

```
tmux new-session -d -s tests -x 200 -y 50
tmux send-keys -t tests "cd tests && npm test" Enter
tmux set-hook -t tests pane-exited "run-shell 'exit_code=#{pane_exit_status}; [ $exit_code -ne 0 ] && tmux capture-pane -t #{pane_id} -p > /tmp/test-failure-#{pane_id}.log'"
```

## Explanation

This workflow runs tests (or any command) in a tmux session and automatically logs output to a file **only if the command fails**. Using hooks on `pane-exited` lets you react to exit codes and capture relevant diagnostics without cluttering your filesystem.

## Example

Run three parallel test suites and auto-save failures:

```bash
tmux new-session -d -s tests
for suite in unit integration e2e; do
  tmux new-window -t tests -n $suite
  tmux send-keys -t tests:$suite "npm run test:$suite" Enter
  tmux set-hook -t tests:$suite pane-exited \
    "run-shell '[[ #{pane_exit_status} -ne 0 ]] && tmux capture-pane -t #{pane_id} -p -S -100 > /tmp/$suite-fail-$(date +%s).log'"
done

# Later, check for failures
ls -la /tmp/*-fail-*.log
```

This keeps logs only for failed runs, so you have a history of what broke and when.
