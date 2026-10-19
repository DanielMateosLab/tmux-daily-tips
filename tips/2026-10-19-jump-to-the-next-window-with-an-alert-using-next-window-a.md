# Jump to the next window with an alert using `next-window -a`

Pressing `prefix` + `M-n` is the usual way to step through windows, but it treats every window the same. Use `next-window -a` to skip straight to the next window that has an activity or bell alert, so you can reach a finished build or a new log line without scanning the whole window list.

## The command

```
tmux next-window -a
```

Like the other `next-window` variants, it can be bound to a key. Add this to `~/.tmux.conf`:

```tmux
bind-key N next-window -a
```

Then reload with `prefix` + `:` and `source-file ~/.tmux.conf`, or with `tmux source-file ~/.tmux.conf` from a shell.

## How it works

`next-window -a` moves forward from the current window and stops at the first window flagged with activity (`#`) or a bell (`!`). If no window is flagged, the command does nothing and you stay where you are.

Alerts only appear when monitoring is enabled. Turn it on for the windows you care about:

```tmux
set-window-option -g monitor-activity on
set-window-option -g monitor-bell on
```

The flags show in the window list in the status bar, so you can see which windows are waiting before you jump.

## Example

Start a long build in one window and keep working in another:

```sh
# window 2: start a build that prints output when finished
make -j8 && echo "build done"
```

Switch to window 1 and keep editing. When the build finishes, window 2 gets an activity flag. Press `prefix` + `N` and tmux moves you straight to window 2, and it skips any other windows that have no alert.
