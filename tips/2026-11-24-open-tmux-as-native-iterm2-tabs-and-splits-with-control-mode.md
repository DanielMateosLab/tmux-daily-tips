# Open tmux as native iTerm2 tabs and splits with control mode

Run `tmux -CC` instead of `tmux` to make iTerm2 render each tmux window as a native tab and each pane as a native split. Scrolling, search, and copy work through iTerm2's own UI.

```sh
tmux -CC new-session -A -s work
```

The `-A` flag attaches to `work` if it exists and creates it otherwise. A single `-C` also works, but it echoes your keystrokes, so iTerm2 uses `-CC`, which turns echo off. Other terminals show raw control-mode output, so use this only in iTerm2.

Detach with `prefix d` as usual. iTerm2 then prints a detached message, and you can reattach later with the same command.

To keep the tabs and splits you arranged, leave the session running and reattach. The layout, window names, and pane contents stay on the tmux server.
