# Show a tmux window's pane count in its tab title with `window_panes`

The `set-titles-string` option controls the terminal window's title, and it accepts the same format variables as the status bar. Pairing `#{window_panes}` with `#{window_name}` puts a live pane count in the terminal title, so you can see how crowded the current window is without looking at tmux at all.

Set it in `~/.tmux.conf`:

```tmux
set -g set-titles on
set -g set-titles-string "#S:#I #{window_name} [#{window_panes}p]"
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

The title now reads something like `work:2 editor [3p]` in the terminal emulator's tab or window bar. Each time you split or join a pane, tmux updates the title on the next redraw.

To show the count only when a window has more than one pane, use a conditional format:

```tmux
set -g set-titles-string "#S:#I #{window_name}#{?#{e|>:#{window_panes},1}, [#{window_panes}p],}"
```

The `#{e|>:...}` expression returns true only when the window holds two or more panes, so single-pane windows keep a clean title.
