# Run Tests in Background and Alert When Done

Run a test suite (or any long-running command) in a background pane, then display a notification when it finishes.

## Command

```tmux
bind-key T run-shell "npm test && tmux display-message 'Tests passed!'" \; send-keys -t test:0 "npm test" Enter
```

## How It Works

`run-shell` executes a shell command outside any pane. Chain commands with `&&` to show a message only if the test passes, or `||` to alert on failure. This keeps your current pane active while tests run silently in the background. For longer waits, redirect output to a file or a background pane.

## Example Setup

Add this to your `.tmux.conf`:

```tmux
# Quick test runner with alert
bind-key T run-shell "cd ~/project && npm test > /tmp/test.log 2>&1 && tmux display-message 'Tests passed! ✓' || tmux display-message 'Tests failed! ✗'"

# Or run in a dedicated background window
bind-key T new-window -n test -d "npm test; sleep 5"
```

Then hit `Prefix T` to start tests. The status bar shows the result without interrupting your work.

## Variation: Capture and Review Results

```tmux
bind-key T run-shell "npm test > ~/.test-output.log 2>&1; tail -20 ~/.test-output.log | tmux display-message -I -"
```

This saves the full output to a file and shows the last 20 lines in the status bar.
