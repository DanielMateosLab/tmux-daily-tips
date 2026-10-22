# Move the status bar to the top with status-position

Tmux draws the status bar at the bottom of the screen by default. Setting `status-position` to `top` moves it to the first row, which keeps it visible on tall terminals and matches the layout of many other tools.

## The option

```
set-option -g status-position top
```

Use `-g` for the global default, or omit it and pass `-s`/`-w` to scope the change to a session or window. Valid values are `top` and `bottom`.

## Toggle it on the fly

Bind a key that flips the position, so you can compare both layouts without editing the config:

```
bind T if-shell -F '#{==:#{status-position},top}' \
  'set -g status-position bottom' \
  'set -g status-position top'
```

Press `prefix` then `T` to switch. Pick a key you do not already use; check with `list-keys` first.

## Example

Add this to `~/.tmux.conf` and reload with `tmux source-file ~/.tmux.conf`:

```
set -g status-position top
set -g status-style 'bg=colour236,fg=colour250'
```

The status bar now sits above the panes, and the window list starts at the left edge of the top row.
