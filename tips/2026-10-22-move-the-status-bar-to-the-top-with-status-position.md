# Move the status bar to the top with status-position

The status bar sits at the bottom of the screen by default. Setting `status-position top` moves it above the panes, which keeps it out of the way of shell prompts that end at the bottom edge and makes the window list read first.

## Command

```
tmux set-option -g status-position top
```

The `-g` flag applies the change to every session on the server. Omit it to set the option for the current session only.

## Example

Add this line to `~/.tmux.conf` so the layout survives restarts:

```
set -g status-position top
```

Then reload the config without restarting tmux:

```
tmux source-file ~/.tmux.conf
```

To toggle between top and bottom on the fly, bind a key that flips the value:

```
bind T if-shell -F '#{==:#{status-position},top}' \
  'set -g status-position bottom' \
  'set -g status-position top'
```

Press `prefix` then `T` to switch. The change takes effect immediately across all clients.
