# Show a tmux window's pane count in its status bar with `#{window_panes}` in a conditional

Print the pane count only when a window has more than one pane, so single-pane windows stay clean.

Add this to `~/.tmux.conf`:

```
set -g window-status-format '#I:#W#{?#{>:#{window_panes},1}, [#{window_panes}],}'
set -g window-status-current-format '#I:#W#{?#{>:#{window_panes},1}, [#{window_panes}],}'
```

The `#{?condition,yes,no}` construct is a format conditional. Here the condition is `#{>:#{window_panes},1}`, which is true when the window holds two or more panes. When it's true, tmux appends ` [N]` after the window name, where `N` is the pane count. When it's false, the empty branch adds nothing.

Reload the config with `prefix` + `:` then `source-file ~/.tmux.conf`, or with the binding from the config-reload tip.

Example: a window named `editor` with three panes appears in the status bar as `2:editor [3]`, while a single-pane window named `logs` appears as `3:logs`.
