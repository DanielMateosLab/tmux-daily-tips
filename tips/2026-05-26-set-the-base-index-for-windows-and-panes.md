# Set the Base Index for Windows and Panes

## The Option

```tmux
set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on
```

## What It Does

By default, tmux numbers windows and panes starting from `0`. That's awkward because `0` sits on the far right of your keyboard, away from `1`–`9`. Setting `base-index 1` and `pane-base-index 1` makes numbering start at `1`, so `prefix 1` jumps to the first window — matching the natural left-to-right key order.

Pair it with `renumber-windows on` so when you close a window, the remaining ones renumber sequentially instead of leaving gaps (e.g., closing window `2` of `1,2,3` shifts `3` down to `2`).

## Example

Add to `~/.tmux.conf`:

```tmux
# Start counting at 1 instead of 0
set -g base-index 1
setw -g pane-base-index 1

# Keep window numbers contiguous after closing one
set -g renumber-windows on
```

Reload the config:

```
prefix : source-file ~/.tmux.conf
```

Now create three windows, close the middle one:

```
Before close:  [1:vim] [2:logs] [3:shell]
prefix &  (kill window 2)
After close:   [1:vim] [2:shell]   # was 3, renumbered to 2
```

`prefix 1` and `prefix 2` always map to what's actually visible — no more hunting for window `7` after closing `2`, `3`, and `5`.

## Why It Matters

This is one of the highest-leverage tweaks in a tmux config: it costs three lines and makes every keyboard jump faster for the rest of your tmux career. Most published `.tmux.conf` files include it for exactly this reason.
