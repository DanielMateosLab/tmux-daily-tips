# Show a tmux window's bell count in the status bar with `#{window_bell_flag}`

Tmux flags a window when something rings the bell in it, but the flag only shows in the window list if you put it there. Add `#{window_bell_flag}` to `window-status-format` to see which background windows rang without switching to them.

The format variable expands to `1` when the window has an unseen bell and to `0` otherwise. Wrap it in a conditional so it only appears when there is something to see:

```
set -g window-status-format "#I:#W#{?window_bell_flag, 🔔,}"
set -g window-status-current-format "#I:#W#{?window_bell_flag, 🔔,}"
```

The `#{?condition,yes,no}` syntax checks the flag and prints the bell emoji only when it is set. The flag clears once you select the window, so the marker disappears as soon as you look at the window that rang.

Reload the config to apply it:

```
tmux source-file ~/.tmux.conf
```

Then run `printf '\a'` in a background window. Its entry in the status bar gains the bell marker, and selecting that window clears it.

The bell only sets the flag when the `bell-action` option lets it, which is `any` by default. Check it with `tmux show -g bell-action`. If you want the flag without the sound, set `set -g visual-bell off` and keep `bell-action` at `any`.
