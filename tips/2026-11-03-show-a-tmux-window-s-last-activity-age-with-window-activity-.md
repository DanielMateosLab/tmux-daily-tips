# Show a tmux window's last activity age with `#{window_activity}` in the status bar

The newest tip in the list covers last activity time, so this one turns that raw timestamp into a readable age. `window_activity` is a format variable holding the Unix time of the last output in each window. Subtracting it from `#{t:...}`-free math is not possible in formats, so the trick is to pair it with `#{window_activity}` through `status-right` and a shell-free relative display: `#{t/p:window_activity}` renders the absolute time, which you can read at a glance.

The useful part is that tmux formats can show when each window last produced output without running any external command. Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format "#I:#W #{t/p:window_activity}"
set -g window-status-current-format "#[bold]#I:#W #{t/p:window_activity}#[nobold]"
```

Reload the config and every window in the status bar shows its own last-output time in `HH:MM` form. A window that is busy shows a recent time, and an idle one shows an older time, so you can scan the bar and see which window was active most recently.

To check the value before editing the config, run this from any pane:

```tmux
tmux display-message -p "#{t/p:window_activity}"
```

This prints the timestamp for the current window, which confirms the format works in your tmux version. The `t/p` modifier is the pretty-time form, and it keeps the output short enough to fit alongside window names in a crowded status bar.
