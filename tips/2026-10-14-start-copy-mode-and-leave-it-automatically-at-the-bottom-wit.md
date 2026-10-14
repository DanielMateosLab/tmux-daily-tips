# Start copy mode and leave it automatically at the bottom with `copy-mode -e`

`copy-mode -e` enters copy mode and exits it as soon as you scroll back to the bottom, so you don't need a separate `q` or `Escape` press to return to live output.

Bind it to a key with `bind-key`, then use `-u` to start one page up:

```tmux
bind-key u copy-mode -eu
```

Press `prefix` then `u` and the pane shows the previous page of scrollback. Scroll down with the mouse wheel or `PageDown`, and copy mode closes once you reach the live prompt again.

Use `-e` alone when you want to browse from the current position. Use `-u` alone when you want the page-up start without auto-exit. Both flags work with the `copy-mode` command from a script or from the command prompt, so `tmux copy-mode -e -t %3` puts another pane into the same mode.
