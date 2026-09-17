# Send Function Keys to Remote Applications

Send function key events (F1–F12) to control remote terminals, text editors, and TUIs without replicating key codes manually.

## Command:

`tmux send-keys -t pane F1` (or `F2`, `F3`, etc.)

## Why this works:

Function keys like F1 (help), F5 (refresh), or F10 (quit) are critical for many terminal applications. `send-keys` translates function key names directly, so you don't need to figure out escape sequences.

## Practical examples:

```sh
# Show help in htop
tmux send-keys -t mywindow:0 F1

# Refresh Midnight Commander
tmux send-keys -t mywindow:1 F5

# Quit an app
tmux send-keys -t mywindow:2 F10
```

## Binding for quick access:

```tmux
bind-key -n F1 send-keys -t last-pane F1
bind-key -n F2 send-keys -t last-pane F2
bind-key -n F3 send-keys -t last-pane F3
```

Now press F1, F2, F3 directly to send them to the last active pane without switching focus.

## Supported variants:

- `F1` through `F12`
- `S-F1` (Shift+F1)
- `C-F1` (Ctrl+F1)
- `M-F1` (Alt+F1)
