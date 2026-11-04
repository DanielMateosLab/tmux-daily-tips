# Show a tmux window's pane count with `#{window_panes}` in a status-style prompt

The latest tips cover pane counts in the status bar, window names, and tab styles. This tip shows how to build a compact `[3p]` badge with `window-status-format`, so you can see a window's split count at a glance without a custom script.

tmux exposes the pane count as the format variable `#{window_panes}`. Combine it with the window index and name in `window-status-format` to get a clean per-window label.

## Example

Add this to `~/.tmux.conf`:

```tmux
set -g window-status-format "#I:#W #[fg=colour244][#{window_panes}p]#[default]"
set -g window-status-current-format "#I:#W #[fg=colour39,bold][#{window_panes}p]#[default]"
```

Reload the config:

```sh
tmux source-file ~/.tmux.conf
```

Each window now shows its index, name, and pane count. The current window uses a brighter colour and bold text, so the active split count stands out.

## Why it helps

`#{window_panes}` updates live as you split or kill panes, so the badge never goes stale. Using `#[...]` style codes keeps the colours inside the format string, which means you need no extra options or scripts. Because the format applies to every window, you can compare split counts across the whole session in one glance.
