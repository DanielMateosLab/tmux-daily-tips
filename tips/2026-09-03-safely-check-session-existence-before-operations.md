# Safely Check Session Existence Before Operations

Use `tmux has-session -t <name>` to check if a session exists before trying to attach, send commands, or create it. This prevents errors and enables conditional workflows.

## Command

```
tmux has-session -t session-name
echo $?  # Returns 0 if exists, 1 if not
```

## Explanation

When scripting tmux operations, attempting to attach or send commands to a non-existent session fails with an error. `has-session` does a silent check, returning an exit code (0 for success, 1 for not found) that you can branch on. This pattern is essential for:
- Safely creating a session only if it doesn't exist
- Sending commands to a session without failing if it's gone
- Monitoring session state programmatically

## Example

```
# Conditional session creation in a startup script
if ! tmux has-session -t work 2>/dev/null; then
  tmux new-session -d -s work -c ~/projects
fi
tmux attach-session -t work

# Or, send a command only if the session exists
if tmux has-session -t build-server; then
  tmux send-keys -t build-server "make test" Enter
fi
```
