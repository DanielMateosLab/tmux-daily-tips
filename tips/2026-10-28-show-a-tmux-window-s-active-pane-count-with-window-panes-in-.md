# Show a tmux window's active pane count with `#{window_panes}` in the window's status-left

Tmux exposes the number of panes in a window as the format variable `#{window_panes}`. Most tips put it in the right-hand status bar or the window name, so this one puts it on the left side of the status line, as a session-level indicator you can read at a glance before switching windows.

Add a `status-left` line to your config that shows the session name followed by the current window's pane count:

```
set -g status-left "[#S] #{window_panes}p "
```

Reload the config:

```
tmux source-file ~/.tmux.conf
```

The left side now reads something like `[work] 3p`, and the number updates as you split or kill panes. Because `status-left` is evaluated per client, the count reflects the window the client currently has focused.

To show the count only when a window has more than one pane, use a conditional format so single-pane windows stay quiet:

```
set -g status-left "[#S] #{?#{e|>:#{window_panes},1},#{window_panes}p ,}"
```

Here `#{e|>:...}` compares the pane count to 1 and `#{?...,...,...}` chooses between the count and an empty string. Check the expansion without touching the bar using:

```
tmux display -p "#{?#{e|>:#{window_panes},1},#{window_panes}p ,}"
```

Run it inside a window that has two panes and it prints `2p `. In a single-pane window it prints an empty line, which confirms the conditional works before you rely on it in `status-left`.
