# Insert New Windows Next to the Current One with `-a`

**Command:** `new-window -a` (and `move-window -a` / `-b`)

By default `prefix c` appends the new window to the *end* of the list. If you are working in window 2 of 9, your new window lands at index 9 — far from the context you just left, and you spend the next minute pressing `prefix n` to get back and forth.

The `-a` flag inserts the window at the **next index after** the current one instead, shifting the later windows up to make room. `-b` inserts it *before* the current window (tmux 3.2+).

## Try it live

```bash
# From window 2, create a new window right after it (becomes window 3)
tmux new-window -a

# Insert before the current window instead
tmux new-window -b

# Insert after a specific window, regardless of where you are
tmux new-window -a -t mysession:1
```

## Make it the default

Rebind `c` so every new window is created adjacent to your current one, inheriting the current directory:

```tmux
# ~/.tmux.conf
bind c new-window -a -c "#{pane_current_path}"

# Keep the old "append to the end" behaviour on another key
bind C new-window -c "#{pane_current_path}"
```

## Reordering existing windows

The same flags work with `move-window`, which is the fast way to drag a stray window back into place without juggling numeric indexes:

```bash
# Move window 7 so it sits immediately after the current window
tmux move-window -a -s 7

# Move window 7 immediately before the current window
tmux move-window -b -s 7
```

A handy binding for pulling a window to your current position:

```tmux
bind M-m command-prompt -p "move window here:" "move-window -a -s '%%'"
```

## Concrete example

You are on window `2:api` debugging a failing request and want a scratch shell for `curl` next to it:

```
Before:  0:editor  1:logs  2:api*  3:db  4:notes

prefix c   ->  0:editor  1:logs  2:api  3:db  4:notes  5:scratch*
prefix c   ->  0:editor  1:logs  2:api  3:scratch*  4:db  5:notes
   (with -a bound)
```

With `-a`, `prefix l` (last window) now bounces between `api` and `scratch`, and `prefix n`/`prefix p` keep the two side by side. When you close the scratch window, the remaining windows keep their relative order — add `set -g renumber-windows on` if you also want the gap closed automatically.
