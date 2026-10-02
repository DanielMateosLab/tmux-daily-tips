# Inspect environment variables in sessions with show-environment

Debugging environment issues like SSH_AUTH_SOCK or PATH problems is easier with show-environment.

```tmux
show-environment -s       # Show session-level variables
show-environment -g       # Show global server variables
show-environment -s name  # Inspect a specific variable
```

When SSH agent forwarding breaks or a tool can't find something, run `show-environment -s` in the problematic session to see what's actually set. Compare against `-g` to spot missing or mismatched variables. Use `set-environment` to fix issues on the fly without reattaching.

**Example:** SSH keys not working in a nested session?

```tmux
# Check what the session inherited
tmux show-environment -s SSH_AUTH_SOCK

# If wrong or empty, fix it
tmux set-environment -s SSH_AUTH_SOCK /tmp/ssh-XXXX/agent.123
```

You can also pipe the output to grep for specific patterns: `tmux show-environment -s | grep PATH`
