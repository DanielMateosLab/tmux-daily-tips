# Show a tmux window's pane count in its status bar with `#{window_panes}` when a session is already set up

Tmux exposes the number of panes in a window through the `window_panes` format variable. Put it in `status-right` or `window-status-format` and you see at a glance how many panes each window holds, without running `list-panes` or opening `choose-tree`.

Note that this tip is about the variable itself. Several earlier tips already cover window pane counts in the status line, so this one only adds a small, dedicated check you can run right now against the current window.

## Check the value from the command prompt

Before you touch any config, print the value with `display-message`:

```
tmux display-message -p '#{window_panes}'
```

The `-p` flag prints to stdout instead of the status bar, so you can also use it from a shell script. Inside a pane it returns the count for the window that pane belongs to.

## Use it in a format string

To see the count for every window in your status bar, add the variable to `window-status-format`:

```
set -g window-status-format ' #I:#W (#{window_panes}) '
set -g window-status-current-format ' #I:#W (#{window_panes}) '
```

Each window tab now reads something like `2:server (3)`, where the number in parentheses is its pane count.

## Use it in a shell script

Scripts can read the same value to decide what to do next. This script splits the current window only when it has a single pane:

```
if [ "$(tmux display-message -p '#{window_panes}')" -eq 1 ]; then
  tmux split-window -h
fi
```

Save this as a file and bind it to a key with `run-shell` if you want a one-key "make two panes" action that does nothing when the window is already split.

## Reload the config

After editing `~/.tmux.conf`, reload it so the new format takes effect:

```
tmux source-file ~/.tmux.conf
```
