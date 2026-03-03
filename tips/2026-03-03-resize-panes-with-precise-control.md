

# Resize Panes with Precise Control

## Shortcut

`Ctrl-b` then `:resize-pane -D 5` (or `-U`, `-L`, `-R`)

For quicker repeated resizing, use the default key bindings:

| Keys | Action |
|------|--------|
| `Ctrl-b Alt-Up` | Resize pane up by 5 rows |
| `Ctrl-b Alt-Down` | Resize pane down by 5 rows |
| `Ctrl-b Alt-Left` | Resize pane left by 5 columns |
| `Ctrl-b Alt-Right` | Resize pane right by 5 columns |
| `Ctrl-b Ctrl-Up` | Resize pane up by 1 row |
| `Ctrl-b Ctrl-Down` | Resize pane down by 1 row |

## Why This Is Useful

When you split your terminal into panes, the default 50/50 split is rarely ideal. You might want a wide editor pane with a narrow shell alongside it, or a tall log viewer with a short command pane below. Precise resizing lets you tailor your layout without destroying and recreating panes.

## Example: 70/30 Vertical Split for Code + Shell

```bash
# Start with a horizontal split (left/right panes)
tmux split-window -h

# Now make the left pane wider by pushing the divider 20 columns right
tmux resize-pane -L 20
```

## Pro Tip: Bind Repeatable Resize Keys

Add this to your `~/.tmux.conf` to resize with `Ctrl-b H/J/K/L` in repeatable mode (hold prefix once, tap direction multiple times):

```
bind -r H resize-pane -L 2
bind -r J resize-pane -D 2
bind -r K resize-pane -U 2
bind -r L resize-pane -R 2
```

The `-r` flag makes the binding repeatable within the `repeat-time` window (default 500ms), so you can tap `H` several times after a single `Ctrl-b` to keep shrinking the pane leftward.

## Quick Reference

```bash
# Resize current pane down by 10 rows
tmux resize-pane -D 10

# Resize a specific pane (pane 2) right by 15 columns
tmux resize-pane -t 2 -R 15

# Even out all panes in the current window
tmux select-layout tiled
```

The `select-layout tiled` command at the end is a handy reset — if your panes get messy, it redistributes space evenly across all of them.
