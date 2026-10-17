# Jump to the Next Window With an Alert Using `next-window -a`

tmux can jump straight to the next window that has an activity or bell alert, so you don't have to cycle through every window to find where something happened.

## Command

```
tmux next-window -a
```

Bind it to a key in your config, for example:

```
bind-key N next-window -a
```

Press `prefix` + `N` to jump to the next window flagged with activity (`#`), a bell (`!`), or silence (`~`) in the status bar.

## Why It Helps

When a long-running build, test suite, or server writes output in a background window, tmux marks that window in the status bar. Cycling with `n` or `p` means stepping past every window in between. `next-window -a` skips straight to the windows that need your attention, in index order after the current window.

## Example

Set up a background build and an alert monitor:

```
tmux new-session -d -s work -n editor
tmux new-window -d -t work -n build "make -j8 && echo done"
tmux set-option -w -t work:build monitor-activity on
```

Now, while you work in `editor`, the `build` window gets an activity flag when output arrives. Press `prefix` + `N` to jump to it without scanning the other windows.

Pair it with `set-option -g visual-activity on` if you also want a status message whenever an alert fires.
