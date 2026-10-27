# Show a tmux window's pane count with a custom format in the status bar

Use `#{window_panes}` in `status-right` or `window-status-format` to show how many panes each window contains, without running any command. This works in any format string, so it stays live as you split and close panes.

Existing tips already cover pane count in the window name, the tab style, and the status bar in several forms. This one covers a different angle: showing the pane count for the *current window only* in the right-hand status area, with a label that only appears when the window is split.

## The format variable

`#{window_panes}` expands to the number of panes in the window. Combine it with a conditional so the label stays hidden for single-pane windows:

```
#{?#{e|>:#{window_panes},1},panes #{window_panes},}
```

`e|>:` is a numeric comparison. The conditional prints `panes N` only when N is greater than 1.

## Example

Add this to `~/.tmux.conf`:

```tmux
set -g status-right '#{?#{e|>:#{window_panes},1},[#{window_panes} panes] ,}%H:%M'
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

Now a window with one pane shows only the clock. Split it once and the status bar reads `[2 panes] 14:32`. Close back to one pane and the label disappears.

To check the value before you commit to a format, run:

```tmux
tmux display-message -p '#{window_panes}'
```

The command prints the pane count for the current window to stdout, which confirms the variable resolves before you embed it in a status string.
