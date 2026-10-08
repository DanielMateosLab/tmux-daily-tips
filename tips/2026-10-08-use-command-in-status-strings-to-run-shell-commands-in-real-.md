# Use `#(command)` in Status Strings to Run Shell Commands in Real Time

**Shortcut:** Use `#(command)` in any format string (like `status-left`, `status-right`, or window titles) to execute a shell command and display its output live.

**Explanation:**
Tmux evaluates commands wrapped in `#(...)` within format strings every few seconds (configurable with `status-interval`). This lets you display dynamic information—git branches, battery percentage, weather, system load—directly in your status bar without external scripts.

**Example:**

Add this to your `.tmux.conf`:

```
set -g status-right "#{?client_prefix,⌨ ,} #[fg=green]#(echo $USER)#[fg=default] | #(date '+%H:%M:%S')"
```

Now your status bar will show:
- A keyboard indicator when the prefix is pressed
- Your username in green
- The current time, updating every second

For a more practical example showing git branch in a window name:

```
bind C-g set-window-option automatic-rename off \; \
  send-keys "clear && #(git branch | grep '\\*' | cut -d' ' -f2-)" Enter
```

**Why:** This is more efficient than spawning background update scripts and keeps all dynamic data in one place.

**Tips:**
- Use `set-option status-interval 5` to control update frequency (default is 15 seconds)
- Heavy commands (like `git status`) can slow your status bar—keep them lightweight
- Combine with `#{pane_current_path}` to run context-aware commands per pane
