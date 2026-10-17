# Jump to the Next Window With an Alert Using `next-window -a`

`next-window -a` (short for `next-window -a`, with the `-a` flag) moves focus to the next window in the session that has an alert flag set, such as bell, activity, or silence. It skips windows with no alerts, so you can work through background tasks that need attention without scanning the window list.

## Why it's useful

When several windows are running long jobs, you usually want to know which one just finished or printed an error. Instead of cycling through every window with `next-window`, the `-a` flag jumps straight to the next one that has signaled something.

## Setup

Alerts only fire for windows where monitoring is enabled. Turn on activity and bell monitoring in your config:

```tmux
set -g monitor-activity on
set -g visual-activity on
set -g monitor-bell on
```

## Binding it to a key

Add a binding that uses the alert-aware variant:

```tmux
bind-key N next-window -a
```

With that in place, press `prefix` then `N` to jump to the next alerting window.

## Example workflow

1. Start a long build in window 1: `make -j8`
2. Start a test run in window 2: `pytest -q`
3. Switch to window 0 and keep working.
4. When the build or tests print output, the window's activity flag is set and the status bar marks it.
5. Press `prefix` then `N` to go straight to the window that reported activity.

## Tip

Pair this with `choose-tree` (`prefix` then `w`) to see every window's alert state at once, then use `next-window -a` for quick hops between them.
