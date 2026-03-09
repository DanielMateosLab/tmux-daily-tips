

# Join a Pane from Another Window

## Shortcut

`Prefix + :` then type `join-pane -s <source>`

## What It Does

The inverse of "break pane" — `join-pane` pulls a pane from another window (or session) and inserts it into your current window as a split. This is perfect when you realize two tasks belong side by side but they're in separate windows.

## Syntax

```
join-pane -s <src-window>.<src-pane> [-t <dst-window>.<dst-pane>]
```

Flags for split direction:

- `-h` — join as a horizontal (left/right) split (default)
- `-v` — join as a vertical (top/bottom) split

## Examples

**Pull pane 0 from window 3 into your current window as a side-by-side split:**

```
:join-pane -h -s 3.0
```

**Pull a pane from a completely different session:**

```
:join-pane -v -s dev:1.0
```

This grabs pane 0 from window 1 of the `dev` session and stacks it below your current pane.

**From the command line (outside tmux or in a script):**

```bash
tmux join-pane -v -s %5 -t %12
```

Use `%`-prefixed pane IDs for precision. Find them with `tmux list-panes -a`.

## Practical Workflow

1. You have a server running in window 2 and logs tailing in window 4
2. You want both visible at once
3. Switch to window 2, then run `:join-pane -v -s 4.0`
4. Now your logs pane is stacked right below your server

## Quick Reference

| Command | Effect |
|---|---|
| `join-pane -h -s 2` | Pull from window 2, horizontal split |
| `join-pane -v -s other:0.1` | Pull from session `other`, vertical split |
| `break-pane` | The reverse — send a pane to its own window |
