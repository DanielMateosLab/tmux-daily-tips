# Split panes with exact row heights using -l

## Command
```
split-window -l 10
split-window -h -l 20
```

## Explanation
Use the `-l lines` flag with `split-window` to create panes with precise height control. Specify the exact number of rows the new pane should occupy. Combine with `-h` for horizontal splits. This complements percentage-based sizing (`-p`) when you need fixed dimensions—like a log viewer that always takes exactly 5 lines, or a status pane that's always 15 rows.

## Example
```
# Create a horizontal split with the new pane exactly 8 rows tall
tmux split-window -l 8

# Create a vertical split on the left, 40 columns wide
tmux split-window -h -l 40

# Bind a key to quickly create a small scratch pane
bind-key S split-window -l 5 "zsh"
```

The remaining space goes to the existing pane, making this ideal for quick info panes that shouldn't steal all available space.
