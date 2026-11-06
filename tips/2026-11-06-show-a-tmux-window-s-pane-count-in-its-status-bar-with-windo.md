# Show a tmux window's pane count in its status bar with `window_panes`

The `#{window_panes}` format variable holds the number of panes in each window. Put it in `status-right` (or any status format) to see the pane count of the current window, and it updates as you split and kill panes.

## Setup

Add this to `~/.tmux.conf`:

```tmux
set -g status-right "#[fg=yellow]panes:#{window_panes} #[default]%H:%M"
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

## Check it from the command line

You can read the value without touching the status bar:

```tmux
tmux display-message -p '#{window_panes}'
```

This prints the pane count of the current window. Target another window with `-t`:

```tmux
tmux display-message -p -t mysession:2 '#{window_panes}'
```

## Why it helps

Splits are easy to lose track of once a window holds four or five panes. A quick glance at the status bar tells you whether the layout you expect is actually there, especially before you run `select-layout` or `join-pane`.
