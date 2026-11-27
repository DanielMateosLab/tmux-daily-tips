# Show a tmux window's pane count in its tab title with `window-status-format`

Tmux stores the pane count as the `#{window_panes}` format variable, so you can show it next to each window name in the status bar without any shell tricks.

## Shortcut / command

```tmux
set -g window-status-format " #I:#W (#{window_panes}) "
set -g window-status-current-format " #I:#W (#{window_panes}) "
```

## Explanation

`window-status-format` controls how each inactive window appears in the status bar, and `window-status-current-format` controls the active window. Both accept format variables wrapped in `#{...}`. `#{window_panes}` expands to the number of panes in that window, so a window with three panes shows `(3)` after its name. Setting both options keeps the active and inactive tabs consistent. Changes apply on the next status redraw, so you do not need to reload the config for the new text to appear once you run `source-file`.

## Example

Add the two lines to `~/.tmux.conf`, then reload:

```sh
tmux source-file ~/.tmux.conf
```

Your status bar now reads something like:

```
 1:editor (2)  2:logs (1)  3:build (4)
```

Here `3:build (4)` means window 3 is named `build` and holds four panes. Pair this with `display-message -p '#{window_panes}'` if you want to check the value for one window before adding it to the config.
