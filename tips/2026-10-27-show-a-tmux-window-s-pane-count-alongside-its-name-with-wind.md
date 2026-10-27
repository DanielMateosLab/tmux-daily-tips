# Show a tmux Window's Pane Count Alongside Its Name with `#{window_panes}`

tmux exposes the number of panes in a window as the format variable `#{window_panes}`. You can use it in `window-status-format` or `window-status-current-format` to show a count next to each window name, which helps you spot split-heavy windows from the status bar without switching to them.

## Usage

Set the format in your config file:

```tmux
set -g window-status-format "#I:#W (#{window_panes})"
set -g window-status-current-format "#[bold]#I:#W (#{window_panes})#[nobold]"
```

Reload the config:

```sh
tmux source-file ~/.tmux.conf
```

Or apply it to the running server directly:

```sh
tmux set -g window-status-format "#I:#W (#{window_panes})"
```

## Example

Suppose you have three windows:

- Window 1 (`editor`) has one pane.
- Window 2 (`logs`) has four panes after a series of splits.
- Window 3 (`build`) has two panes.

The status bar then reads:

```
1:editor (1)  2:logs (4)  3:build (2)
```

The active window gets bold styling from `window-status-current-format`, so you can see at a glance which windows are crowded and which are simple.

## Tip

Pair this with `#{window_zoomed_flag}` if you also want to know whether a window is zoomed, since zoomed windows still report their full pane count even though only one pane is visible.
