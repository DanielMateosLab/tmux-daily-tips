# Size the main pane exactly with main-pane-width and main-pane-height

Tmux's `main-horizontal` and `main-vertical` layouts give one large pane and stack the rest beside or below it. By default the main pane takes a fixed share of the window. Set `main-pane-width` or `main-pane-height` to pick its size in columns or rows, or as a percentage.

## Setting the size

Both options are window options. Set them with `-w` so they apply only to the current window:

```
tmux set -w main-pane-width 120
tmux set -w main-pane-height 40
```

A value with a `%` sign is a percentage of the window:

```
tmux set -w main-pane-width 60%
```

Switch to a main layout to see the effect. The main pane keeps the size you set when the window is resized, as long as the terminal has room for it.

## Example

Give a wide editor pane 140 columns on the left, and put the rest of the panes in a narrow column on the right:

```
tmux set -w main-pane-width 140
tmux select-layout main-vertical
```

To make the same setting the default for every new window, set it globally with `-g`:

```
tmux set -g main-pane-width 140
```

Undo a window override with `-u`, which returns the window to the global value:

```
tmux set -wu main-pane-width
```
