# Move the status bar to the top with `status-position`

Set `status-position` to `top` to move the status bar from the bottom of the window to the top edge. Use `bottom` to switch it back. The option is a session option, so `-g` applies it to every session.

Run it on the fly from the command prompt, or with `tmux` from a shell:

```sh
tmux set -g status-position top
```

To make it permanent, add the line to `~/.tmux.conf` and reload with `prefix` + `:` then `source-file ~/.tmux.conf`:

```tmux
set -g status-position top
```

Putting the status line at the top keeps the bottom row free for shell prompts and editor status lines that already sit there. It also helps when a full-screen program puts its own hints at the bottom, because the window list and session name stay visible without overlapping them.

The option works alongside the other status settings. For example, you can combine it with `status-justify` to center the window list on the top line:

```tmux
set -g status-position top
set -g status-justify centre
```

If you run nested sessions, set the option only in the outer session with `-t` so the inner status bar stays where you expect.
