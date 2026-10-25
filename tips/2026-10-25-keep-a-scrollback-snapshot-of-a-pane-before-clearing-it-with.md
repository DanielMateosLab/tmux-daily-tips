# Keep a Scrollback Snapshot of a Pane Before Clearing It with `capture-pane -S` and `-E`

tmux can capture only a slice of a pane's history, which is useful when you want to save a specific block of output (for example, a failed build) before clearing the pane.

## Command

```sh
tmux capture-pane -p -S <start> -E <end> -t <pane>
```

- `-p` prints the captured text to stdout instead of a paste buffer.
- `-S` sets the start line. Negative numbers count back from the bottom of the visible area into history.
- `-E` sets the end line, using the same numbering.
- `-t` targets the pane.

## Explanation

Lines are numbered so that `0` is the first visible line, positive numbers go down, and negative numbers reach into scrollback. Capturing `-S -2000 -E -1` grabs the 2,000 lines of history immediately above the visible screen, leaving out what's currently shown.

This is handy before running `clear` or `send-keys C-l`: you can save the earlier output first, then wipe the pane without losing the record.

## Example

Save the last 500 lines of history from the current pane to a file, then clear it:

```sh
tmux capture-pane -p -S -500 -E -1 -t : > ~/build-before-clear.log
tmux send-keys -t : C-l
```

If the build output scrolled past the top of the screen, `build-before-clear.log` now contains it, and the pane is clean for the next run.
