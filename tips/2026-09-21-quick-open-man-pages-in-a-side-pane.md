# Quick Open Man Pages in a Side Pane

**Shortcut:**
```
bind-key M command-prompt -p "man:" "split-window -h 'man %'"
```

**Explanation:**
Pressing `C-b M` prompts you for a command name, then opens its man page in a side-by-side pane. Useful for quick reference without leaving tmux.

**Example:**
Press `C-b M`, type `grep`, hit Enter. A new pane opens showing `man grep` next to your current pane.

To customize the split direction (vertical instead of horizontal):
```
bind-key M command-prompt -p "man:" "split-window -v 'man %'"
```

Or to open in a new window instead:
```
bind-key M command-prompt -p "man:" "new-window 'man %'"
```
