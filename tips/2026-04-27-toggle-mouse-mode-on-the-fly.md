# Toggle Mouse Mode On the Fly

**Command:** `:set -g mouse on` / `:set -g mouse off`

By default tmux ignores your mouse, but you can flip it on whenever you need to scroll, click panes, or drag dividers — without committing to it permanently in your config. This is great when you're pairing with someone who expects mouse support, demoing in a meeting, or just want to scroll a long log without dropping into copy mode.

When mouse mode is on, you can:
- Click a pane to focus it
- Click a window name in the status bar to switch
- Drag pane borders to resize them
- Scroll with the wheel (tmux automatically enters copy mode)
- Right-click for context menus (in tmux 3.0+)

## Example

Turn it on temporarily:

```
Prefix : set -g mouse on
```

Turn it back off when you want pure keyboard control:

```
Prefix : set -g mouse off
```

Bind a single key to toggle it, so you don't have to type the command:

```tmux
# In ~/.tmux.conf
bind m set -g mouse \; display-message "Mouse: #{?mouse,on,off}"
```

Now `Prefix m` flips mouse mode and shows the new state in the status bar.

## Tip

If you want the mouse on for the current session only (without affecting future sessions), drop the `-g` flag:

```
Prefix : set mouse on
```

This sets it on the current session, leaving your global default untouched — handy when you only need mouse support for a specific debugging task.
