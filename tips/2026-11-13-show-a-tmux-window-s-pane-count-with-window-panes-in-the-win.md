# Show a tmux window's pane count with `window-panes` in the window-status format

Interpolate `#{window_panes}` into `window-status-format` to see how many panes each window holds, without the window name being cluttered by a separate status segment.

Most people show the pane count in the status bar as a standalone segment, but `window-status-format` already renders once per window, so it is the natural place to attach the count next to the window name.

## Example

Add this to `~/.tmux.conf`:

```
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

Reload the config:

```
tmux source-file ~/.tmux.conf
```

Each window tab now reads something like `1:editor (3)`, where the number in parentheses is the pane count. Splitting or joining panes updates the count on the next status refresh.

To keep the current window visually distinct, give it a different style on the current format only:

```
set -g window-status-current-format " #I:#W (#{window_panes}) "
set -g window-status-current-style "bold,reverse"
```

Run `tmux display-message -p '#{window_panes}'` inside any window to confirm the value tmux will substitute.
