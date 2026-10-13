# Inspect Pane Sizes Without Parsing Output: `display-message -p` with Format Variables

Use `display-message -p` with format variables to read exact pane state as plain text, which is handy for scripts and quick checks. (Note: `#{pane_mode}` and related flags are covered elsewhere; this tip focuses on size and geometry.)

## Command

```
tmux display-message -p '#{pane_width}x#{pane_height}'
```

## Explanation

`display-message -p` prints its result to stdout instead of the status bar. Combined with format variables like `#{pane_width}`, `#{pane_height}`, `#{pane_left}`, and `#{pane_top}`, you get machine-readable geometry for the current pane. Pass `-t` to target a different pane without switching focus.

Common geometry variables:

- `#{pane_width}` and `#{pane_height}`: size in cells
- `#{pane_left}` and `#{pane_top}`: position relative to the window
- `#{window_width}` and `#{window_height}`: the enclosing window's size

Because the output goes to stdout, you can capture it in a shell variable and branch on it, for example to pick a split direction that suits the available space.

## Example

Split horizontally only when the pane is wide enough, otherwise split vertically:

```
tmux if-shell -F '#{>:#{pane_width},160}' 'split-window -h' 'split-window -v'
```

Or check a target pane's size from a script:

```
tmux display-message -p -t %3 '#{pane_width}'
```
