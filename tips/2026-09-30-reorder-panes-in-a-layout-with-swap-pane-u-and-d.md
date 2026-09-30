# Reorder Panes in a Layout with swap-pane -U and -D

When working with complex pane layouts, you may want to rearrange panes without recreating splits. The `-U` and `-D` flags on `swap-pane` let you bubble panes up or down through pane order quickly.

## The shortcut

```tmux
swap-pane -U   # Swap current pane with the one "above" it
swap-pane -D   # Swap current pane with the one "below" it
```

Or bind them:

```tmux
bind -n M-{ swap-pane -U
bind -n M-} swap-pane -D
```

## How it works

- `swap-pane -U` exchanges the current pane with the pane numbered one slot "above" (earlier in pane order)
- `swap-pane -D` exchanges the current pane with the pane numbered one slot "below" (later in pane order)

The physical movement depends on your layout and which pane is current, making it intuitive for shuffling positions.

## Example

With a 3-pane layout (panes 0, 1, 2):

```
  0 | 1
  --+--
    2
```

In pane 0, run `swap-pane -D` to swap with pane 1:

```
  1 | 0
  --+--
    2
```

Run it again to bubble pane 0 further down the order.

## Pro tip

Bind to Alt combinations for muscle memory:

```tmux
bind -n M-{ swap-pane -U
bind -n M-} swap-pane -D
```

Now Alt+{ and Alt+} let you shuffle panes without thinking about their indices or recreating your layout.
