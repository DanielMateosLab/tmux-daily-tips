# Using `confirm-before` to Add Safety Confirmations to Risky Operations

**Command:**
```
bind-key k confirm-before -p "Kill pane? (y/n) " kill-pane
```

**Explanation:**
The `confirm-before` command wraps any tmux operation with an interactive prompt. Instead of instantly deleting a pane when you press `k`, you'll get a yes/no confirmation. This prevents accidental loss of work. The `-p` flag customizes the prompt message.

**Example:**
```
# In .tmux.conf
bind-key k confirm-before -p "Kill pane? (y/n) " kill-pane
bind-key K confirm-before -p "Kill window? (y/n) " kill-window
bind-key C confirm-before -p "Kill session? (y/n) " kill-session
```

When you press `k`, you'll see:
```
Kill pane? (y/n)
```

Press `y` to confirm, `n` to cancel, or any other key to abort.

**Use case:**
Wrap destructive operations with `confirm-before` to avoid muscular accidents when working quickly or under pressure. Trades a single keypress for safety on operations that can't be undone.
