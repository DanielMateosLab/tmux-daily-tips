# Refresh the status bar on a timer with status-interval

The `status-interval` option sets how often tmux redraws the status bar, in seconds. The default is 15. Lower it to keep a clock or a shell-driven readout current, or set it to `0` to stop automatic redraws.

```tmux
set -g status-interval 5
```

Run `tmux set -g status-interval 5` from a shell to apply it to the running server, or add the line to `~/.tmux.conf` and reload it with `tmux source-file ~/.tmux.conf`. Check the current value with `tmux show -gv status-interval`.

tmux re-runs every `#(...)` shell substitution in `status-left` and `status-right` on each refresh. A short interval therefore runs those commands more often, so keep them fast. A slow command at a 1-second interval will make the status bar lag and can keep a CPU core busy.

Here is a status line that shows the 1-minute load average and the time, refreshed every 5 seconds:

```tmux
set -g status-interval 5
set -g status-right '#[fg=yellow]load #(cut -d " " -f1 /proc/loadavg 2>/dev/null || sysctl -n vm.loadavg | awk "{print \$2}") #[default]%H:%M:%S'
```

On macOS, `/proc/loadavg` does not exist, so the fallback `sysctl` branch supplies the value. The `%H:%M:%S` format puts seconds in the clock, which only updates when the interval is 1 or more. For a per-second clock, set the interval to `1` and keep the shell substitution out of the status line.

To see the change immediately without waiting for the next tick, run `tmux refresh-client -S` in the client. The status bar then redraws with the new content right away.
