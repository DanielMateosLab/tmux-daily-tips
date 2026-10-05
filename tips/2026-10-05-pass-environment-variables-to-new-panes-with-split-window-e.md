# Pass environment variables to new panes with split-window -e

When you split a window, you can specify environment variables for that pane without setting them globally.

## Command

```bash
tmux split-window -e "VAR1=value1" -e "VAR2=value2"
```

## Explanation

The `-e` flag lets you inject environment variables directly into a new pane at creation time. This is useful when you want to test code with different configurations or isolate development environments without polluting your shell's global environment.

Variables set this way are available immediately in the new pane and don't affect other panes or windows.

## Example

```bash
# Split and create a pane with a test environment
tmux split-window -e "DEBUG=1" -e "NODE_ENV=test"

# The new pane now has those variables:
# $ echo $DEBUG
# 1
```

You can also use it with `new-window`:

```bash
tmux new-window -e "PYTHONUNBUFFERED=1" -e "APP_MODE=dev"
```

This is especially helpful for:
- Running tests with specific flags
- Isolating staging/production configs
- Quick one-off debugging without shell configuration changes
