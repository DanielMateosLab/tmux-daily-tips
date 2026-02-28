# Swap Panes Instantly with `{` and `}`

## Shortcut

| Action | Keybinding |
|---|---|
| Swap current pane with previous | `Prefix` + `{` |
| Swap current pane with next | `Prefix` + `}` |

## What It Does

These bindings physically move the current pane to the position of its neighbor. The pane content, running process, and working directory all travel with it. This is different from switching *focus* between panes (`Prefix + o`) — here, the panes themselves change places in the layout.

## When to Use It

- You split a window and realize the left/right or top/bottom arrangement is backwards
- You want your primary working pane in a larger region without re-creating it
- You're arranging a multi-pane layout and need to reorder without closing anything

## Example

Say you have a three-pane horizontal layout:

```
┌──────────┬──────────┬──────────┐
│  editor  │  server  │  tests   │
│  (pane 0)│  (pane 1)│  (pane 2)│
└──────────┴──────────┴──────────┘
```

Your cursor is on `pane 1` (server). Press `Prefix + {` and the layout becomes:

```
┌──────────┬──────────┬──────────┐
│  server  │  editor  │  tests   │
│  (pane 0)│  (pane 1)│  (pane 2)│
└──────────┴──────────┴──────────┘
```

The server pane moved left, swapping positions with the editor pane.

## Bonus: Swap by Target

For non-adjacent swaps, use the command directly:

```bash
# Swap pane 0 with pane 2
tmux swap-pane -s 0 -t 2
```

You can find pane numbers with `Prefix + q`, which briefly flashes each pane's index.
