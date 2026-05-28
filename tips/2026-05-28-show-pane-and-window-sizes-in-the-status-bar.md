# Show Pane and Window Sizes in the Status Bar

Add live pane and window dimensions to your status line using the `#{pane_width}`, `#{pane_height}`, `#{window_width}`, and `#{window_height}` format variables. This is invaluable when you're working with terminal apps that care about size — like editors with column rulers, TUIs with breakpoints, or when reproducing layout-sensitive bugs.

## The Setting

```tmux
set -g status-right '#{pane_width}x#{pane_height} | %H:%M'
```

Or, to show both the active pane and the full window dimensions:

```tmux
set -g status-right 'pane:#{pane_width}x#{pane_height} win:#{window_width}x#{window_height}'
```

## Why It's Useful

Tmux panes don't always match your terminal size — splits, zoomed panes, and resized clients all change the usable area. Without a visible size indicator, you often have to run `stty size` or `tput cols` to check. Putting the dimensions in the status bar means they update live as you resize, split, or zoom.

## Concrete Example

Add this to `~/.tmux.conf`:

```tmux
set -g status-right '#[fg=cyan]#{pane_width}×#{pane_height}#[default] | %H:%M '
set -g status-interval 1
```

Reload with `prefix + :` then `source-file ~/.tmux.conf`.

Now split a pane with `prefix + %` and watch the right-hand side of the status bar update from something like `120×40` to `60×40` instantly. Resize the pane with `prefix + Ctrl+→` and you'll see the numbers tick up in real time — perfect for setting up a pane to exactly 80 or 120 columns for code review or terminal screenshots.

## Bonus: A Quick One-Off Check

If you don't want to edit your config, you can flash the size on demand:

```bash
tmux display-message '#{pane_width}x#{pane_height}'
```

Bind it to a key for instant inspection:

```tmux
bind S display-message '#{pane_width}×#{pane_height}'
```

Press `prefix + S` whenever you need to know the current pane's size without polluting your scrollback.
