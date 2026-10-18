# Control How Often the Status Bar Refreshes with `status-interval`

The status bar redraws on its own timer, and `status-interval` sets that timer in seconds. The default is `15`, which is why a live clock or a `#(...)` shell segment can look stale. Lower the value for faster updates, or set it to `0` to disable periodic refreshes entirely.

## Command

```sh
tmux set -g status-interval 1
```

Run it from a shell to apply it immediately, or add the line to `~/.tmux.conf` to make it permanent.

## Explanation

- `-g` sets the value globally for all sessions.
- Each tick re-evaluates every format in `status-left` and `status-right`, including `#(...)` shell commands. Values of `1` are fine for formats like `%T`, but any `#(...)` command you add will run once per tick, so keep those commands fast.
- A value of `0` stops automatic redraws. The bar then updates only when tmux has a reason to redraw, such as a window change or a manual `refresh-client -S`.

## Example

Show a seconds-precision clock and the load average, refreshed every second:

```sh
tmux set -g status-interval 1
tmux set -g status-right '#[fg=cyan]load #(cut -d" " -f1 /proc/loadavg 2>/dev/null || sysctl -n vm.loadavg | awk "{print \$2}") #[default]| %H:%M:%S '
```

On macOS, which has no `/proc/loadavg`, the `sysctl` fallback is used. Leave `status-interval` at `15` if you only need minute-level accuracy, since each tick spawns the shell command.
