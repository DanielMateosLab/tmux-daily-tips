# Show a tmux window's pane count with a conditional format in the status bar

Use `#{?condition,yes,no}` in `window-status-format` to show a pane count only on windows that actually have more than one pane. Single-pane windows stay clean, and split windows get a visible `[n]` marker.

## Why it helps

The plain `#{window_panes}` format variable prints a number on every window, including the ones you never split. A conditional hides the noise and draws your eye only to windows where the layout matters.

## The setting

```tmux
set -g window-status-format "#I:#W#{?#{>:#{window_panes},1},[#{window_panes}],}"
set -g window-status-current-format "#I:#W#{?#{>:#{window_panes},1},[#{window_panes}],}"
```

`#{>:a,b}` returns true when `a` is greater than `b`. The `?` picks the text before the comma when the condition is true, and the text after it when false. Here the false branch is empty, so single-pane windows show only their index and name.

## Example

Put the lines in `~/.tmux.conf`, then reload:

```sh
tmux source-file ~/.tmux.conf
```

With a window `1:editor` holding one pane, a window `2:server` holding three panes, and a window `3:logs` holding two panes, the status bar reads:

```
1:editor  2:server[3]  3:logs[2]
```

Reload with `prefix + r` if you bound it, or run the `source-file` command above from any shell.
