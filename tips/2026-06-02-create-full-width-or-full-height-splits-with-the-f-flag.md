# Create Full-Width or Full-Height Splits with the `-f` Flag

By default, `split-window` divides only the current pane, so a new split inherits whatever space that pane occupies. The `-f` (full) flag tells tmux to split across the entire window instead, spanning the full width or height regardless of the existing layout.

## The shortcut

```
prefix : split-window -fh    # full-height pane on the right, spanning the whole window
prefix : split-window -fv    # full-width pane on the bottom, spanning the whole window
```

Combine `-f` with `-b` to place the new pane *before* (left/top) the target, and with `-l` to set its size.

## Why it matters

Picture a window with three stacked panes on the left. A normal `split-window -h` only splits the one pane you're in, giving you a short right-hand pane. With `-fh` you get a tall right-hand pane that runs the full height of the window next to all three — perfect for a log tail, a REPL, or a monitor that should sit alongside everything.

## Example

Bind two handy keys in `~/.tmux.conf`:

```tmux
# Full-height vertical split on the right, 80 columns wide
bind | split-window -fh -l 80

# Full-width horizontal split on the bottom, 12 rows tall
bind _ split-window -fv -l 12
```

Now build a layout in seconds:

```
# Start with one pane, make a couple of stacked panes on the left
prefix "          # normal horizontal split
prefix "          # again — now three short panes stacked

# Add a tall sidebar spanning all of them
prefix |          # full-height pane on the right, 80 cols
```

The result is three small panes on the left and one tall pane on the right — something a plain split can't produce without manual resizing.

## Tip

Run the new pane in its own directory or command at the same time:

```tmux
bind L split-window -fv -l 15 -c "#{pane_current_path}" "tail -f *.log"
```

This opens a full-width 15-row pane at the bottom, in the current pane's directory, already tailing your logs.
