# Quickly Swap Two Windows with `swap-window`

**Command:** `:swap-window -s <src> -t <dst>` or the shortcut `prefix + .` (move) combined with target indexing

Tmux lets you reorder windows on the fly without killing and recreating them. The `swap-window` command exchanges the position of two windows by index, so you can keep your mental layout (editor on 1, server on 2, logs on 3) even when windows were created out of order.

There are two common patterns:

- **Swap current window with another:** `:swap-window -t 3` — swaps the active window with window index 3.
- **Swap two specific windows:** `:swap-window -s 2 -t 5` — exchanges windows 2 and 5 regardless of which is active.

For sliding (not swapping) a window to a new index, use `move-window`: `:move-window -t 1` relocates the current window to index 1, shifting others as needed. Add `-r` to renumber all windows sequentially after a reorder: `:move-window -r`.

## Example

You have:

```
0: shell    1: logs    2: editor    3: server
```

You want the editor on window 1. From the editor window, run:

```
prefix + :
swap-window -t 1
```

Result:

```
0: shell    1: editor    2: logs    3: server
```

## Bonus: bind it for one-key reordering

Add to `~/.tmux.conf`:

```tmux
bind -r < swap-window -t -1 \; select-window -t -1
bind -r > swap-window -t +1 \; select-window -t +1
```

Now `prefix + <` and `prefix + >` shuffle the current window left or right and follow it. The `-r` flag makes the binding repeatable, so you can hold the key after one prefix press to keep nudging the window into place.
