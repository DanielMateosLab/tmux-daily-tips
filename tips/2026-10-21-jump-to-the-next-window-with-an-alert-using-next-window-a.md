# Jump to the next window with an alert using `next-window -a`

Press `prefix` then `n` to move to the next window, but `next-window -a` (and `previous-window -a`) skips straight to the next window that has an alert, such as a bell, activity, or silence flag. This makes it easy to reach a long-running build or test window that finished while you were working somewhere else.

Add these bindings to `~/.tmux.conf`. The keys are an example, so pick any unused ones:

```tmux
bind N next-window -a
bind P previous-window -a
```

Reload the config with `prefix` then `:source-file ~/.tmux.conf`, or with the `source-file` command from the reload tip.

## Example

1. Start a build in window 3 with `make all; tmux bell` (or enable `bell-action` and `monitor-bell`).
2. Switch to window 1 and keep working.
3. When the build finishes and rings the bell, window 3 is flagged in the status bar.
4. Press `prefix` then `N`. tmux jumps to window 3 without you checking each window in turn.

If no window has an alert, the command does nothing and you stay on the current window.

## Notes

- `-a` works with `next-window` and `previous-window`, and it cycles from the current window onward.
- Alert flags are cleared once you visit the window, so the next `prefix` + `N` moves on to the next flagged window.
- The alert types that count are the ones enabled in `monitor-activity`, `monitor-silence`, and `bell-action`.
