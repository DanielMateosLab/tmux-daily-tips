# Send multiline code blocks with heredocs using send-keys

**Shortcut:** `send-keys 'cat << EOF' Enter '<content>' Enter 'EOF' Enter C-m`

**Explanation:**

Use `send-keys` with heredoc syntax to inject multiline configuration files, scripts, or code into remote shells without worrying about local quoting. Heredocs are built into POSIX shells and work reliably across different environments. This is safer than trying to escape complex strings and works even when the remote shell doesn't support some quoting styles.

**Example:**

Create a quick script in a remote pane:

```tmux
bind-key C-i send-keys 'cat << EOF > deploy.sh' Enter \
  '#!/bin/bash' Enter \
  'echo "Deploying..."' Enter \
  'docker pull myapp:latest' Enter \
  'EOF' Enter C-m
```

Or inject an environment file:

```tmux
tmux send-keys -t mywindow 'cat << CONF > config.env' Enter \
  'DATABASE_URL=postgres://localhost' Enter \
  'API_KEY=secret123' Enter \
  'CONF' Enter C-m
```

The heredoc approach survives shell escaping issues, special characters, and nested quotes. Use different delimiters (EOF, CONF, SCRIPT) to avoid conflicts with the content itself.
