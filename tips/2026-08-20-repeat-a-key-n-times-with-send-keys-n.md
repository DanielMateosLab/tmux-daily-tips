# Repeat a Key N Times with send-keys -N

**Command:** `send-keys -N <count> <key>`

Use the `-N` flag to repeat sending the same key multiple times to a pane without typing it repeatedly. Perfect for scrolling, cursor movement, or any action you need to repeat a fixed number of times.

**Example:**

Scroll down 10 lines:

```
tmux send-keys -N 10 Down
```

Create a keybinding in `.tmux.conf` to page down with one keystroke:

```
bind-key C-Down send-keys -N 10 Down
```

Or in a script, send a key sequence multiple times:

```bash
tmux send-keys -t mywindow:0 -N 5 Right
```

Much simpler than typing the key manually, and it avoids shell loops in automation.
