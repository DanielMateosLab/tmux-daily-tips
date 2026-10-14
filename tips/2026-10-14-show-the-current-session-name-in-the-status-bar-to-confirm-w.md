# Show the current session name in the status bar to confirm which session you're in

Tmux exposes the session name as the `#S` format variable, so you can display it permanently in the status bar. This matters when you run several sessions and need to confirm where a keystroke will land before you type it.

Add this to `~/.tmux.conf`:

```
set -g status-left "[#S] "
set -g status-left-length 20
```

Reload with `prefix` then `:source-file ~/.tmux.conf`, or run `tmux source-file ~/.tmux.conf` from any shell.

The status bar now starts with the session name in brackets. Run `tmux new -s work` and the left side reads `[work]`. Switching sessions with `prefix` then `s` updates the label immediately, so you always know which session is active.

To include the window index as well, use `#I` alongside `#S`:

```
set -g status-left "[#S:#I] "
```

This shows `[work:2]` for window 2 of the `work` session. Keep `status-left-length` at 20 or higher if you add more text, otherwise tmux truncates the label.
