

# Bind Custom Key Tables for Modal Workflows

## The Shortcut

`prefix + T` (custom binding) → enter a dedicated key table for a specific task, then `q` to exit back to normal mode.

## What It Does

tmux supports **custom key tables** beyond the built-in `prefix` and `copy-mode` tables. You can define your own named table with its own set of bindings, creating modal interfaces — similar to vim modes — for specialized workflows like window management, resizing, or navigation.

When you switch to a custom key table, every keypress is interpreted against that table until you explicitly leave it. This eliminates the need to keep pressing the prefix key repeatedly.

## Setup

Add to your `~/.tmux.conf`:

```tmux
# Enter "window mode" with prefix + T
bind T switch-client -T windowmode

# Window mode bindings (no prefix needed while active)
bind -T windowmode h select-window -t :-
bind -T windowmode l select-window -t :+
bind -T windowmode n new-window
bind -T windowmode x confirm-before kill-window
bind -T windowmode s split-window -v
bind -T windowmode v split-window -h
bind -T windowmode r command-prompt "rename-window '%%'"

# Repeat-friendly resize mode
bind R switch-client -T resizemode
bind -T resizemode h resize-pane -L 5
bind -T resizemode j resize-pane -D 5
bind -T resizemode k resize-pane -U 5
bind -T resizemode l resize-pane -R 5

# Any unbound key in the table automatically exits back to normal
```

## How It Works

1. Press `prefix + T` — you enter `windowmode`
2. Now press `h`, `l`, `n`, `x` etc. **without any prefix** — each keypress triggers its binding
3. Press any key not bound in the table (like `q` or `Escape`) — tmux exits the table and returns to root

For a **repeatable** mode (stay in the table after each keypress), add `-r` to each binding:

```tmux
bind -T resizemode -r h resize-pane -L 2
bind -T resizemode -r j resize-pane -D 2
bind -T resizemode -r k resize-pane -U 2
bind -T resizemode -r l resize-pane -R 2
```

With `-r`, the table stays active for the `repeat-time` duration (default 500ms) after each keypress, letting you tap `h h h` to resize incrementally.

## Example Session

```
# Rapidly rearrange windows without prefix spam:
prefix + T → h h l l n → (moved left twice, right twice, created new window)

# Resize a pane by feel:
prefix + R → j j j l l → (grew pane down 15, right 10)
```

## Listing Your Custom Tables

To see all bindings in a custom table:

```sh
tmux list-keys -T windowmode
```

This is a powerful way to build task-specific interfaces without polluting the default prefix keyspace.
