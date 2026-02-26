

# Swap Panes Instantly with `swap-pane`

## The Shortcut

**Prefix + `{`** — swap the current pane with the previous one
**Prefix + `}`** — swap the current pane with the next one

## What It Does

`swap-pane` physically moves a pane to another pane's position within the same window. Unlike `select-pane` (which just shifts focus), this actually rearranges your layout — the pane contents, sizes, and positions get exchanged.

This is invaluable when you split your terminal and realize your editor ended up on the wrong side, or your log tail should be at the bottom instead of the top.

## Usage

### Keyboard Shortcuts

```
Prefix + {    # Move current pane "backward" (swap with previous)
Prefix + }    # Move current pane "forward" (swap with next)
```

### Command Form

```bash
# Swap current pane with pane 0
tmux swap-pane -t 0

# Swap pane 1 and pane 3 explicitly
tmux swap-pane -s 1 -t 3

# Swap without changing focus (stay on the original pane position)
tmux swap-pane -d -t 2
```

## Concrete Example

You have a three-pane layout:

```
┌──────────┬──────────┐
│  0: vim  │ 1: tests │
├──────────┘          │
│ 2: server logs      │
└─────────────────────┘
```

You want your server logs next to vim and tests at the bottom. Focus on pane 1, then press **Prefix + `}`** to swap it with pane 2:

```
┌──────────┬──────────┐
│  0: vim  │ 1: logs  │
├──────────┘          │
│ 2: tests            │
└─────────────────────┘
```

## Pro Tip

Combine with `display-panes` (**Prefix + `q`**) to see pane numbers before swapping. You can even type the pane number while the indicators are showing to select it, then use `swap-pane -t` to target it precisely.

```bash
# Bind a quick "swap with last active pane" shortcut
bind S swap-pane -t !
```

The `-t !` target refers to the last active pane, making it a fast toggle between two panes you're working with.
