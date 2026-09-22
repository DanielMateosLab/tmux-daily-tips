# Navigate Panes Interactively with choose-pane

**Command:** `choose-pane`

**Keybinding:**
```tmux
bind p choose-pane
```

Interactively select a pane from a menu instead of typing numbers or cycling through them. Displays all panes with their IDs and current command, lets you pick one with arrow keys or by typing its ID.

**Variants:**
- `choose-pane` — panes in the current window
- `choose-pane -s` — panes across all windows in the current session
- `choose-pane -t session:` — panes in a specific session

**Example:**

Bind a key to jump between panes visually:
```tmux
bind p choose-pane
```

When you press `Prefix + p`, a menu appears:
```
 0: [100x30] "zsh" (active)
 1: [100x15] "vim"
 2: [100x15] "npm start"
```

Use arrow keys to highlight and Enter to switch. Avoids remembering pane numbers and beats cycling with arrow keys in complex layouts. Combines with `-F` to filter by command or custom criteria.
