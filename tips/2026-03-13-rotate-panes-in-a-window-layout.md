# Rotate Panes in a Window Layout

**Shortcut:** `Prefix + Ctrl-o` (rotate forward) / `Prefix + Alt-o` (rotate backward)

## What It Does

Rotates all panes in the current window, cycling their positions without changing the layout structure. The pane contents move, but the split geometry stays fixed.

This is different from swapping two specific panes — rotation shifts *every* pane in the window by one position.

## Commands

| Action | Shortcut | Command |
|---|---|---|
| Rotate forward | `Prefix + Ctrl-o` | `tmux rotate-window` |
| Rotate backward | `Prefix + Alt-o` | `tmux rotate-window -D` |
| Rotate by 2 positions | — | `tmux rotate-window && tmux rotate-window` |

## Example

Suppose you have a three-pane layout — an editor on the left, logs top-right, and a shell bottom-right:

```
┌──────────┬──────────┐
│          │  logs    │
│  editor  ├──────────┤
│          │  shell   │
└──────────┴──────────┘
```

Press `Prefix + Ctrl-o` and each pane's content shifts to the next position:

```
┌──────────┬──────────┐
│          │  editor  │
│  shell   ├──────────┤
│          │  logs    │
└──────────┴──────────┘
```

The layout (one big left pane, two stacked right panes) stays the same — only the contents rotate.

## When This Is Useful

- You realize your main editing pane would work better in the larger split
- You want to quickly cycle through which process gets the "big" pane without manually re-splitting
- You're screen-sharing and want to reposition a pane for visibility without disrupting your layout

## Bonus: Combine with Layout Presets

Rotate works with any layout, including the built-in presets (`Prefix + Alt-1` through `Alt-5`). Set a layout first, then rotate to get exactly the right content in each position:

```bash
# Switch to main-vertical layout, then rotate logs into the large pane
tmux select-layout main-vertical
tmux rotate-window -D
```
