# Send copy-mode yanks to the macOS clipboard with copy-command

The `copy-command` option tells tmux which program receives text yanked in copy mode. Set it once and every yank lands in the system clipboard, without relying on the terminal to honour the OSC 52 sequence. This requires tmux 3.2 or later.

## Setting it

Add this line to `~/.tmux.conf` on macOS:

```
set -g copy-command 'pbcopy'
```

On Linux, use `wl-copy` for Wayland or `xclip -selection clipboard` for X11 instead.

Reload the config without restarting tmux:

```
tmux source-file ~/.tmux.conf
```

## Example

1. Press `prefix` then `[` to enter copy mode.
2. Move to the text you want with the arrow keys or `hjkl` if you use vi mode.
3. Press `Space` to start a selection, move to the end, then press `Enter` or `y` to copy.
4. Switch to any other app and press `Cmd+V`. The text is there.

Before this option, the same yank only filled tmux's internal paste buffer. You would have to run `prefix` then `]` inside tmux to paste it, and nothing reached the clipboard outside tmux.

To check the value tmux is using, run:

```
tmux show -g copy-command
```

If the output is empty, the line was not loaded, so confirm the path to your config file and run the reload command again.
