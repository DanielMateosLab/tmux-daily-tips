# Jump to a Pane by Number with `display-panes`

**Shortcut:** `Prefix + q`

When a window has more than two or three panes, navigating with arrow keys gets tedious. `display-panes` overlays a large, easy-to-read number on each pane. Press the matching digit and tmux jumps straight to that pane — no cycling required.

## How it works

By default, the indicators disappear after one second (`display-panes-time`). If you press a digit while they are visible, that pane becomes active. You can extend the timeout so you have more time to read and react.

## Example

Press `Prefix + q` in a window with four panes:

```
┌──────────┬──────────┐
│          │          │
│    1     │    2     │
│          │          │
├──────────┼──────────┤
│          │          │
│    3     │    4     │
│          │          │
└──────────┴──────────┘
```

Press `3` and the bottom-left pane becomes active.

## Useful tweaks

Add to `~/.tmux.conf`:

```tmux
# Keep numbers visible for 4 seconds instead of 1
set -g display-panes-time 4000

# Make the numbers easier to read
set -g display-panes-active-colour colour33
set -g display-panes-colour colour245
```

You can also trigger it from the command line, handy inside scripts or other key bindings:

```sh
tmux display-panes
```

Combine with `-d` to skip waiting for selection (just show the numbers and return), or bind it to a faster key if you use it constantly:

```tmux
bind -n M-q display-panes
```

Now `Alt + q` shows pane numbers without the prefix — one of the fastest ways to navigate a busy layout.
