# Chain Commands with Proper Error Handling Using send-keys

Execute multi-step workflows safely by chaining commands with `&&` and `||` operators in a single `send-keys` call. This ensures subsequent commands only run if previous ones succeed.

## Shortcut

```
tmux send-keys -t pane_id 'cd /project && npm install && npm test || echo "Build failed"' Enter
```

## Explanation

When using `send-keys`, you can send multiple shell commands separated by `&&` (run only if previous succeeds) or `||` (run only if previous fails). This prevents cascading failures where a failed `cd` would silently continue, masking errors. The pattern gives you control over error handling without writing complex shell scripts.

## Example

Monitor a build process with immediate feedback:

```
tmux send-keys -t main_pane 'npm build && npm test && echo "✓ Success" || notify-send "Build failed"' Enter
```

Or safely navigate and run setup:

```
tmux send-keys -t app_pane 'cd ~/myapp && git pull && npm install && npm start' Enter
```

If any step fails (non-zero exit), the chain stops. Use `||` to specify fallback actions like notifications, rollbacks, or cleanup.

This is especially useful when orchestrating multi-pane workflows where you want consistent error handling across distributed commands.
