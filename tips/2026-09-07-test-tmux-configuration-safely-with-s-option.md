# Test Tmux Configuration Safely with -S Option

## Command

```
tmux -S /tmp/test-server new-session -d -s work
tmux -S /tmp/test-server attach -t work
```

## Explanation

Use `-S` to specify an alternate socket file, creating an isolated tmux server independent of your running sessions. Perfect for safely testing configuration changes, new keybindings, and layouts without disrupting your active workflow. The test server starts fresh until you source a config file.

## Example

Create a test server and verify your configuration:

```
tmux -S /tmp/test new-session -d -s test
tmux -S /tmp/test source-file ~/.tmux.conf
tmux -S /tmp/test list-keys | head -20
```

Attach to the test server:

```
tmux -S /tmp/test attach -t test
```

Kill the test server when done:

```
tmux -S /tmp/test kill-server
```

Use this before deploying config changes to avoid breaking your active tmux sessions.
