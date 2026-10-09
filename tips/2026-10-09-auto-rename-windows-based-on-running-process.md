# Auto-Rename Windows Based on Running Process

**Option:**
```
set-option -g automatic-rename on
```

**Explanation:**
When `automatic-rename` is enabled, tmux automatically updates each window's name to match the currently running command. This gives you instant visibility into what's executing in each window without manual naming.

**Example:**
Add to your `tmux.conf`:
```
set-option -g automatic-rename on
set-option -g automatic-rename-format '#{pane_current_command}'
```

Now when you run `vim`, the window shows "vim"; when you `cd` to a directory, it updates to show the shell; running `npm start` displays "npm". The name changes as processes come and go.

Combine with custom status bar format to show both window index and auto-detected command:
```
set-option -g window-status-format '#I: #{window_name}'
set-option -g window-status-current-format '#I: #{window_name} *'
```

Great for monitoring multiple active processes across windows without cluttering your layout with manual names.
