# Move Panes Between Windows with `join-pane` and `break-pane`

Sometimes you realize a pane belongs in a different window, or you want to pull a pane out into its own window. tmux lets you shuffle panes between windows without losing any state.

## Break a Pane Into Its Own Window

**Shortcut:** `Prefix` + `!`

This detaches the current pane from its window and places it in a brand new window. The process running in the pane is completely unaffected.

**Command equivalent:**

```
tmux break-pane
```

## Join a Pane From Another Window

This is the reverse — pull a pane from one window into another as a split.

```
tmux join-pane -s :2
```

This takes the active pane from window **2** and joins it into your current window as a vertical split.

### Useful Flags

| Flag | Effect |
|------|--------|
| `-s :N` | Source: pane from window N |
| `-t :N` | Target: send current pane to window N |
| `-h` | Join as a horizontal split (side by side) |
| `-v` | Join as a vertical split (stacked, default) |

## Concrete Example

You're running a dev server in window 1 and logs in window 2. You want the logs next to the dev server:

```bash
# From window 1, pull the pane from window 2 as a side-by-side split
tmux join-pane -h -s :2
```

Now both panes share window 1 in a horizontal layout.

To undo it, focus the logs pane and press `Prefix` + `!` — the logs pane pops back out into its own window.

## Targeting Specific Panes

You can be precise with `window.pane` syntax:

```bash
# Pull pane 1 from window 3 into the current window
tmux join-pane -s :3.1

# Send the current pane to window 0, stacked vertically
tmux join-pane -v -t :0
```

## Why This Matters

Rearranging your workspace on the fly — without restarting processes — keeps you in flow. No need to kill a running tail, rebuild, or re-SSH into a box just because you want a different layout.
