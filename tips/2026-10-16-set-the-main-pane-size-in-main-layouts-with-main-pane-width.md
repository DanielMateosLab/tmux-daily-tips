# Set the Main Pane Size in Main Layouts with `main-pane-width`

The `main-vertical` and `main-horizontal` layouts give one large "main" pane and stack the rest beside or below it. By default tmux sizes the main pane by percentage, which can be too narrow for a long editor or too wide for a log. The `main-pane-width` and `main-pane-height` options set an exact size in columns or rows.

## Commands

```sh
tmux set-option -g main-pane-width 120     # columns for main-vertical
tmux set-option -g main-pane-height 30     # rows for main-horizontal
```

Apply a layout with `M-4` (`main-vertical`) or `M-3` (`main-horizontal`), which are tmux's default bindings for those layouts. You can also run:

```sh
tmux select-layout main-vertical
```

## Explanation

- `main-pane-width` and `main-pane-height` take an absolute cell count, so the main pane keeps the same size whatever the terminal dimensions.
- `other-pane-width` and `other-pane-height` work the same way for the secondary panes.
- The options are per-window, so use `set-window-option -t` to change one window only. Use `-g` to set the default for all windows.
- Once you resize the main pane by hand, tmux keeps your manual sizes until you reapply the layout.

## Example

Put this in `~/.tmux.conf` to give the editor a 120-column main pane and leave the rest for shells:

```tmux
set -g main-pane-width 120
set -g other-pane-width 40
set -g main-pane-height 30
```

Then reload the config and apply the layout:

```sh
tmux source-file ~/.tmux.conf
# prefix + M-4 (Alt-4) to apply main-vertical
```

Your editor stays at 120 columns on any terminal width, and new shells stack in the remaining space.
