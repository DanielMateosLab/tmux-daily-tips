# Monitor a Pane for Activity or Silence

## The Commands

```
Prefix + M          # Toggle activity monitoring on the current window
```

Or via the command line:

```bash
tmux set-option -w monitor-activity on
tmux set-option -w monitor-silence 30
```

## What It Does

**Activity monitoring** alerts you when output appears in a background window — useful when waiting for a long build, test suite, or deployment to produce results.

**Silence monitoring** does the opposite: it alerts you when a window has had *no output* for a specified number of seconds — perfect for knowing when a noisy log stream has gone quiet, meaning a process finished or stalled.

When triggered, the window's name highlights in the status bar and tmux displays a brief message.

## Practical Examples

### Watch for a build to finish

You kick off a build in window 2, then switch to window 1 to keep working:

```bash
# In window 2, start the build
make -j8

# Switch to window 1
# Press: Prefix + M   (enables monitor-activity on window 2 before leaving)
```

When the build emits output (or you set it on the build window and switch away), the status bar flags window 2.

### Detect when a log stream goes quiet

You're tailing logs during a deploy and want to know when it settles:

```bash
# Set a 30-second silence monitor on the current window
tmux set-option -w monitor-silence 30

# Tail the deploy logs
tail -f /var/log/deploy.log
```

Switch to another window and work. After 30 seconds of no new log lines, tmux notifies you.

### Combine both in a script

```bash
# Launch a test suite in a new window with both monitors
tmux new-window -n tests 'npm test'
tmux set-option -w -t tests monitor-activity on
tmux set-option -w -t tests monitor-silence 15
```

## Turning It Off

```bash
tmux set-option -w monitor-activity off
tmux set-option -w monitor-silence 0
```

## Tip

Add `set -g visual-activity on` to your `~/.tmux.conf` to get a message-line notification instead of just a status-bar highlight. Use `visual-silence on` for the same with silence alerts.
