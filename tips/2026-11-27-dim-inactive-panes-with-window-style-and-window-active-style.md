# Dim inactive panes with window-style and window-active-style

Set `window-style` and `window-active-style` to give unfocused panes a darker background, so the active pane stands out. tmux applies `window-active-style` to the focused pane and `window-style` to every other pane in the window.

Both options take the same style syntax as `pane-border-style`, so you can set `bg`, `fg`, or attributes. Use `bg=default` or `bg=terminal` for the active pane to keep your terminal's own background.

Add this to `~/.tmux.conf`:

```tmux
set -g window-style 'bg=colour235'
set -g window-active-style 'bg=terminal'
```

Then reload the config:

```sh
tmux source-file ~/.tmux.conf
```

To test the effect on one window without touching the config, set the option with `-w`:

```sh
tmux set -w window-style 'bg=colour236'
tmux set -w window-active-style 'bg=terminal'
```

Run `tmux show -wv window-style` to confirm the value. Dimmed panes keep their text colors, so a dark `bg` works best with a light or default foreground. Light themes need the inverse: a slightly brighter `bg` for inactive panes.
