# Refresh the status bar on a timer with status-interval

Tmux redraws the status bar on its own schedule, which is why a clock or a battery indicator can look stale. The `status-interval` option sets how often tmux re-runs the status formats, in seconds. It defaults to 15, and setting it to 1 makes the status line update every second.

Set it for the running server with `set -g status-interval 1`, or add the line to `~/.tmux.conf` to keep it across restarts. Pair it with a `#()` command in `status-right` to show output from a script that changes over time.

For example, to show the current load average and refresh it every five seconds:

```tmux
set -g status-interval 5
set -g status-right "load #(uptime | awk -F'load averages?: ' '{print $2}' | cut -d' ' -f1) | %H:%M"
```

Tmux runs each `#()` command once per interval, so a slow script delays the whole status bar. Keep the command fast, or cache its result in a file and read the file from the status line.

Setting the interval to 0 turns off periodic refresh entirely. The status bar then updates only when tmux has a reason to redraw, such as a window change or a client resize.
