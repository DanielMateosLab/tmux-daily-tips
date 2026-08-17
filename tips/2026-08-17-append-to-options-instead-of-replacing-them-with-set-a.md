# Append to Options Instead of Replacing Them with `set -a`

**Shortcut:** `set -ag option value` (or `set -a` at the command line)

When you use `set` without `-a`, it *replaces* the entire option. With the `-a` flag, tmux *appends* your value instead — perfect for building status bars, key binding sequences, or command chains without losing existing configuration.

**Example:**

```
set -ag status-left "[#S] "
set -ag status-right "#{cpu_percentage} | %H:%M "
```

Instead of replacing `status-left` and `status-right` entirely, these commands add your segments. This is especially useful when you want to layer configuration from multiple files or add context-specific elements without rewriting the whole option.

**Real-world usage:**

```
# In your main config:
set -g status-left "#{session_name}"

# In a project-specific override:
set -ag status-left " → project-x"

# Result: "session-name → project-x"
```

Use `-ag` for global append, `-as` for server-wide, or `-aw` for window-specific. Combine with `source-file` to layer configs cleanly.
