I'll pick a tip that isn't covered yet: using `move-window` to reorder windows with `-a`, `-b`, and `-t` anchors. Several existing tips cover window moves (swap, insert before/after, renumber, move between sessions), but none covers relocating a window to a named index.

# Move a window to an exact index with move-window -t

Use `move-window -t` with a target index to place the current window at a specific position, shifting others out of the way only when you ask. This gives you direct control over tab order, which the `swap-window` and `next-window`-style tips don't offer.

## The command

```
tmux move-window -t <index>
```

Run it from the prompt, or bind it with `command-prompt` so you can type the index on demand.

## Example

Suppose your session has windows 0 through 5 and you want the current window at position 1. Run:

```
tmux move-window -t 1
```

If window 1 already exists, tmux refuses with "index in use". Add `-k` to replace it, or move the occupied window out of the way first:

```
tmux move-window -t 1 -k
```

To leave the current window in place but jump it to the next free slot, omit `-t` and tmux picks the lowest unused index.

## Binding it to a key

Add this to `~/.tmux.conf` to prompt for the destination index:

```
bind-key M command-prompt -p "move window to:" "move-window -t '%%'"
```

Press `prefix` then `M`, type a number, and press Enter. The `%%` placeholder inserts whatever you typed into the command.
