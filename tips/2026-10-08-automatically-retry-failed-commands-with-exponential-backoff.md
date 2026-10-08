# Automatically Retry Failed Commands with Exponential Backoff Using send-keys

## Shortcut
```
tmux send-keys -t PANE "retry() { local n=1; local max=5; while true; do if \"\$@\"; then return 0; fi; [ \$n -lt \$max ] && { echo 'Retry in '$((2**n))'s...'; sleep \$((2**n)); ((n++)); } || return 1; done; }; retry COMMAND" Enter
```

## Explanation

When automating tasks in tmux (deployment scripts, API calls, flaky tests), commands often fail transiently. Rather than immediate re-execution, exponential backoff reduces load and improves success rates. Use send-keys to inject a retry wrapper function that escalates delays: 2s, 4s, 8s, 16s.

The function runs your command and, if it fails, waits before retrying. Each wait doubles: `2^n` where n increments. After max attempts (5), it gives up.

## Example

Test a network-dependent command:
```bash
# In one pane, send the retry function once:
tmux send-keys -t dev "retry() { local n=1; local max=5; while true; do if \"\$@\"; then return 0; fi; [ \$n -lt \$max ] && { echo 'Retry in '$((2**n))'s...'; sleep \$((2**n)); ((n++)); } || return 1; done; }; retry curl https://flaky-api.example.com" Enter

# Output:
# curl: Failed
# Retry in 2s...
# curl: Failed  
# Retry in 4s...
# (success)
```

Combine with other panes using `send-keys -t :0 -t :1` to retry the same operation in parallel, or loop the function across multiple hosts:

```bash
tmux send-keys -t dev "for host in server1 server2; do echo \"Testing \$host\"; retry ssh \$host 'uptime'; done" Enter
```
