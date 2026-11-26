# Resize a pane by dragging its border with `resize-pane -M`

`resize-pane -M` switches a pane into mouse resize mode, so you can drag any border to resize it. It works from a key binding, which saves you from typing the command.

## The command

```
tmux resize-pane -M
```

Run it from a shell, or bind it to a key in `~/.tmux.conf` so it fires from inside tmux.

## Why it helps

Mouse dragging on borders works by default when `mouse` is on, but it only catches a border you grab directly. Keyboard-driven resizing with `resize-pane -L`, `-R`, `-U` and `-D` moves one cell per keypress. `-M` gives you a third option: start a resize with a key, then drag the border with the mouse until it sits where you want. Pick this when you need a rough size and don't want to count cells.

Mouse support must be on for this to work:

```
set -g mouse on
```

## Example

Add a binding to `~/.tmux.conf`:

```
bind M resize-pane -M
```

Reload the config with `prefix` then `:source-file ~/.tmux.conf`, or with the binding from [the source-file tip](2026-04-16-use-source-file-to-reload-config-without-restarting.md).

Then press `prefix` followed by `M`, move the pointer to the border you want to resize, and drag. The pane follows the pointer until you release the button.

Run `tmux resize-pane -M` from a shell if you want to try it without editing the config first. The command is accepted, but the drag only takes effect when a mouse event reaches tmux, so the key binding is the more reliable route.
