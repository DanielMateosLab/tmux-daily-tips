# Show a tmux pane's exit status in a status line with `#{pane_dead_status}`

When a pane runs a command with `remain-on-exit` enabled, tmux keeps the pane around after the process exits. The exit code is available through the `pane_dead_status` format variable, so you can display it without scrolling back through output.

## Setup

Turn on `remain-on-exit` for the pane or window, then add the format variable to a status format:

```tmux
set -g remain-on-exit on
set -g status-right "#{?pane_dead,exit: #{pane_dead_status},running} | %H:%M"
```

`pane_dead` is `1` once the process has exited, so the conditional shows the exit code only for dead panes and `running` otherwise.

## Example

Run a build that may fail, then check the result from the status bar:

```sh
tmux new-window -n build 'make test; echo done'
```

When `make test` exits with status `2`, the status bar shows `exit: 2` for that window. If you want the value for the current pane only, use the same expression in `display-message`:

```sh
tmux display-message -p '#{pane_dead_status}'
```

This prints `0` for success, the exit code for failures, and an empty line for panes still running.

## Tip

Pair this with `respawn-pane -k` to rerun a failed command in place. The status line tells you what happened, and the respawn keeps the same pane and layout.
