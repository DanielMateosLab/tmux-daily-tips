# Enter vi-Mode Using send-keys Escape

**Command:**
```
tmux send-keys Escape
```

**Explanation:**
If your shell has vi-mode enabled (`set -o vi` in bash, `bindkey -v` in zsh), sending Escape enters normal mode, letting you edit the command line with vi keybindings. Useful for editing complex commands or automating shell interactions from tmux.

**Setup (in .bashrc or .zshrc):**
```bash
set -o vi  # bash
bindkey -v  # zsh
```

**Examples:**

Enter vi-mode and jump to start of line:
```
tmux send-keys -t pane Escape Home
```

Delete from cursor to end of line:
```
tmux send-keys -t pane Escape D
```

Append to end of line and add text:
```
tmux send-keys -t pane Escape End i " && echo Done" Enter
```

**Keybinding for quick access:**
```
bind e send-keys Escape  # Alt+E enters vi-mode
```

**Use case:**
Automate editing previous commands by combining with history navigation:
```
tmux send-keys -t pane Up Escape 0 w d w  # edit second word of previous command
```
