# Create an Always-Accessible Scratchpad Pane with Toggle Visibility

**Shortcut:**
```
bind-key C-q if-shell "tmux list-windows -t scratchpad" "select-window -t scratchpad" "new-window -t scratchpad -n scratch"
```

**Explanation:**

Create a dedicated scratchpad window that toggles on and off with a single keystroke. This pane acts as a persistent note-taking, calculation, or command-testing area without disrupting your main workflow. The binding checks if a "scratchpad" window already exists—if it does, it switches to it; if not, it creates one on first use.

**Example:**

Add this to your `~/.tmux.conf`:

```
bind-key C-q if-shell "tmux list-windows -t scratchpad" \
  "select-window -t scratchpad" \
  "new-window -t scratchpad -n scratch"
```

Now press `Ctrl+q` to toggle to your scratchpad. Use it for temporary notes, quick calculations, or testing commands without cluttering your main panes. Press `Ctrl+q` again in any other window to jump back.

**Refinement:**

If you want the scratchpad to auto-clear on each visit:

```
bind-key C-q if-shell "tmux list-windows -t scratchpad" \
  "select-window -t scratchpad; send-keys -t scratchpad 'clear' Enter" \
  "new-window -t scratchpad -n scratch; send-keys -t scratchpad 'clear' Enter"
```
