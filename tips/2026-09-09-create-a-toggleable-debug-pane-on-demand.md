# Create a toggleable debug pane on demand

Instantly spawn a side-by-side debug pane and kill it with the same key—great for testing, calculations, or quick lookups without losing focus.

```bash
bind-key d if-shell "tmux list-panes -t '#{session_name}' -F '#{pane_title}' | grep -q '^debug$'" \
  "kill-pane -t #{session_name}:debug" \
  "split-window -t '#{session_name}' -h -p 25 -c '#{pane_current_path}'; send-keys -t #{session_name}:debug 'set-pane-title debug' Enter"
```

On first press, a 25%-width debug pane appears to your right. Press again to kill it. The pane opens in your current working directory and closes cleanly.

**Why:** Beats creating windows or juggling splits. You're already at your prompt when it vanishes, no refocusing needed.

**Example workflow:**

```bash
# Press Prefix+d: debug pane appears
# Run calculations or test commands
python3 -c "print(2**16)"  # Quick eval
# Press Prefix+d again: pane gone, focus back to main window
```

Bind it to any key; `d` for debug is just a suggestion.
