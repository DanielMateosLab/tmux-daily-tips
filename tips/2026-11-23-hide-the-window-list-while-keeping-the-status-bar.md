# Hide the window list while keeping the status bar

Use `status` with `set -g status-left` and `status-right` to keep the status bar visible, but hide the window list entries. Setting `window-status-format` and `window-status-current-format` to an empty string removes the window tabs from the bar without touching `status`.

```
set -g window-status-format ""
set -g window-status-current-format ""
```

Reload the config with `prefix` + `:` then `source-file ~/.tmux.conf`, or run the two lines directly from the command prompt.

For a session-only change that does not touch the config file, run:

```
tmux set -g window-status-format "" \; set -g window-status-current-format ""
```

The status bar keeps showing `status-left` and `status-right`, so session name, time, or any custom segment stays visible. Revert with `set -gu window-status-format` and `set -gu window-status-current-format` to restore the defaults.
