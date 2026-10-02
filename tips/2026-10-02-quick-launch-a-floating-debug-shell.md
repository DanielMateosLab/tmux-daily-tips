# Quick Launch a Floating Debug Shell

**Shortcut:** `bind-key -n M-Escape new-window -t @floating -n debug -d "bash" \; display-popup -t @floating -w 120 -h 30`

**What it does:**

Creates a lightweight floating pane for quick debugging or testing without disrupting your current layout. Pressing `Alt+Escape` spawns a full bash shell in a hidden floating popup. When you exit the shell, the popup closes automatically and you're back where you were.

**Why it's useful:**

Often you need to quickly run a command, check something, or test code without losing focus or disrupting your carefully arranged panes. This gives you an isolated, disposable shell on top of everything else.

**Configuration:**

Add this to your `tmux.conf`:

```tmux
# Quick floating debug shell
bind-key -n M-Escape new-window -t @floating -n debug -d "bash" \; \
  display-popup -t @floating -w 120 -h 30 -x 5 -y 5
```

Or for Zsh:

```tmux
bind-key -n M-Escape new-window -t @floating -n debug -d "zsh" \; \
  display-popup -t @floating -w 120 -h 30 -x 5 -y 5
```

**Usage:**

- Press `Alt+Escape` to launch the floating shell
- Type your commands or tests
- Type `exit` to close the floating pane and return to your session
- The debug window remains in the background; press `Alt+Escape` again to reuse it

**Pro tip:** Change `-w 120 -h 30` to adjust the floating pane size, or `-x 5 -y 5` to reposition it on screen.
