

# Monitor Activity in Background Panes with `monitor-activity`

## The Problem

When working with multiple tmux panes or windows, you might have long-running processes (builds, test suites, log streams) running in background windows. You have no way to know when something happens without manually switching to check.

## The Solution

Use `monitor-activity` to get notified when output appears in a background window.

## Command

```
# Enable for the current window
Ctrl-b : set-option monitor-activity on

# Or target a specific window
tmux set-option -t :2 monitor-activity on
```

## How It Works

Once enabled, tmux highlights the window name in your status bar whenever new output appears in that window. By default, the window name is marked with `#` and the status bar text changes color.

## Practical Example

Say you're running a build in window 1 and editing code in window 0:

```bash
# In window 1, start your build
npm run build --watch

# Switch to window 0
Ctrl-b 0

# Enable monitoring on window 1
tmux set-option -t :1 monitor-activity on
```

Now whenever the build produces output (success or error), window 1 lights up in your status bar.

## Companion: `monitor-silence`

The inverse is also useful — get notified when a window **stops** producing output:

```bash
# Alert if no output for 30 seconds
tmux set-option -t :3 monitor-silence 30
```

This is perfect for watching a log stream — if it goes quiet, something may be wrong.

## Controlling the Visual Alert

You can customize how the notification appears:

```bash
# Change the style of monitored windows in the status bar
tmux set-option -g window-status-activity-style "fg=red,bold"

# Suppress the status line message (keep only the highlight)
tmux set-option -g visual-activity off
```

## Quick Toggle

Bind a key to toggle monitoring on the current window:

```bash
# In ~/.tmux.conf
bind m set-option monitor-activity \; display-message "Monitor: #{?monitor-activity,ON,OFF}"
```

Now `Ctrl-b m` toggles activity monitoring and confirms the state.
