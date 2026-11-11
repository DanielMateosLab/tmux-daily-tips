# Show a tmux window's pane count in its status bar with `#{window_panes}`

Use the format variable `#{window_panes}` in `status-right` or `window-status-format` to see how many panes each window holds, without running a command.

The variable expands to the number of panes in the window it belongs to. Put it in `window-status-format` to show the count next to every window name, or in `status-right` to show the count for the current window only. tmux evaluates it on each status refresh, so the number stays current as you split and kill panes.

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format "#I:#W [#{window_panes}]"
set -g window-status-current-format "#I:#W [#{window_panes}]*"
```

Reload the config:

```sh
tmux source-file ~/.tmux.conf
```

Each window in the status bar now shows its pane count in brackets. Split the current window and the count goes from `[1]` to `[2]` on the next refresh.

To check the value from the command line before editing the config, run:

```sh
tmux display-message -p -t mysession:1 '#{window_panes}'
```

This prints the pane count for window 1 of `mysession`.
