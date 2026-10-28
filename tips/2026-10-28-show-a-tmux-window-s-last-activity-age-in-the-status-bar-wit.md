# Show a tmux window's last-activity age in the status bar with `#{t:window_activity}`

The `window_activity` format variable holds the Unix time of the last output in a window. Wrap it in the `t:` modifier and tmux prints a human-readable timestamp instead of a raw number.

Add this to `~/.tmux.conf` to show when each window last produced output:

```tmux
set -g window-status-format " #I:#W (#{t:window_activity}) "
set -g window-status-current-format " #I:#W (#{t:window_activity}) "
```

Reload with `prefix + r` (if bound) or `tmux source-file ~/.tmux.conf`.

Each window tab now reads something like `1:server (14:32:07)`, so you can tell at a glance which background window has been quiet the longest.

To see the value once without editing the config, run:

```sh
tmux display-message -p '#{t:window_activity}'
```

The `t:` modifier formats the time using the server's local timezone. Use `t/p:` instead if you want a relative form like `5 minutes ago` in recent tmux versions that support it.
