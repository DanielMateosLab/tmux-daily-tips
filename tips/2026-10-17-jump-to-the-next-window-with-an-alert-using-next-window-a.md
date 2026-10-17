# Jump to the Next Window with an Alert Using `next-window -a`

Instead of cycling through every window to find the one that needs you, `next-window -a` (and `previous-window -a`) jumps straight to the next window that has a bell or activity alert.

## Setup

Alerts only fire if monitoring is enabled. Add this to `~/.tmux.conf`:

```tmux
setw -g monitor-activity on
set -g bell-action any
```

Then bind the alert jump keys:

```tmux
bind N next-window -a
bind P previous-window -a
```

Reload with `prefix + r` (see [source-file](2026-04-16-use-source-file-to-reload-config-without-restarting.md)) or run:

```sh
tmux source-file ~/.tmux.conf
```

## How It Works

- A window gets an alert when it has activity (`monitor-activity`) or rings the bell (`bell-action`).
- `prefix + N` moves to the next alerted window, clearing its flag as you land on it.
- If no window has an alert, the command does nothing, so the keys are safe to press at any time.

## Example

Suppose you have five windows running:

1. `editor`
2. `server` (printing logs)
3. `tests` (a long build that finishes)
4. `db`
5. `shell`

While you work in `editor`, `tests` finishes and rings the bell. Press `prefix + N` and tmux selects `tests` directly, skipping `server` and `db` even though they also have output.

To check which windows are flagged before jumping, run:

```sh
tmux list-windows -F '#{window_index}: #{window_name} #{window_flags}'
```

Flags like `#` (activity) and `!` (bell) show which windows are waiting for you.
