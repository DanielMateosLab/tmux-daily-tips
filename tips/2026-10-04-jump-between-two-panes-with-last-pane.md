# Jump Between Two Panes with `last-pane`

**Command:**
```
tmux last-pane
```

**Keybinding:**
```
bind-key C-o last-pane
```

**Explanation:**
`last-pane` switches to the previously active pane in the current window. This is perfect for toggling back and forth between two panes without needing to remember their numbers. It's like Alt+Tab for tmux panes.

**Example:**

Add to your `.tmux.conf`:
```
bind-key C-o last-pane
```

Now in your workflow:
- You're in pane 0 editing code
- Switch to pane 1 to check logs with an arrow key
- Press Ctrl+O to jump back to pane 0
- Press Ctrl+O again to jump back to pane 1

**Bonus:**
Combine with other pane selection to create a rapid switching workflow:
```
bind-key '0' select-pane -t 0
bind-key '1' select-pane -t 1
bind-key C-o last-pane  # Quick toggle between wherever you came from
```

This is especially useful when monitoring output in one pane while actively developing in another, or comparing logs across two panes rapidly.
