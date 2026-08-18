# Print the new window ID with new-window -P for immediate scripting

When you create a window, use the `-P` flag to print its ID to stdout. This avoids running `list-windows` afterward—you can immediately reference the window in subsequent commands without guessing or parsing its index.

```bash
WINID=$(tmux new-window -t session -n editor -c ~/code -P)
echo $WINID  # Prints: 3
tmux send-keys -t session:$WINID 'vim main.py' Enter
```

Without `-P`, you'd have to run `list-windows` to find the newly created window's ID. The `-P` flag returns it directly as a captured string.

It also works with `new-session`, `split-window`, and `split-window -h`:

```bash
SID=$(tmux new-session -d -s work -P)
WID=$(tmux new-window -t work -n build -P)
PID=$(tmux split-window -t work:build -P)
```

This is essential for shell scripts that spawn and immediately configure panes without manual lookup.
