# Jump to the Next Window With an Alert Using `next-window -a`

tmux can jump straight to the next window that has an unseen alert (bell, activity, or silence) without you having to scan the status bar.

## Command

```
tmux next-window -a
```

Bind it to a key in your config so it's one keypress away:

```
bind n next-window -a
```

With the default prefix (`C-b`), press `prefix` then `n` to move to the next alerting window.

## Explanation

`next-window` cycles through windows in index order. Adding `-a` (alert) changes the behavior: tmux skips windows without a flag and only stops on windows that have a bell, activity, or silence alert set. This is especially useful when you're running many long jobs across windows and only want to visit the ones that need attention.

Alerts are only visible on windows you're not currently looking at, so the typical flow is:

1. Start a long-running task in a background window.
2. Keep working in another window.
3. When the task finishes or rings the bell, its window gets flagged.
4. Press `prefix` `n` to jump directly to it.

Make sure the alert types you care about are enabled. For example, to be notified on bells and activity:

```
set -g monitor-activity on
set -g visual-bell on
```

## Example

Start a build in window 2 and keep working in window 1:

```
tmux new-window -t 2 -n build "make all; printf '\a'"
```

When `make` finishes, the bell flags window 2. From any other window, press `prefix` `n` (or run `tmux next-window -a` from a shell) to land on it immediately.
