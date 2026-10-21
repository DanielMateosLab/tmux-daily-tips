# Show a tmux Pane's Foreground Process Name with `pane_current_command`

Use the `pane_current_command` format variable to see which program is currently running in a pane, without leaving tmux or running `ps`.

## Command

```sh
tmux display-message -p -t <target> '#{pane_current_command}'
```

## Explanation

`pane_current_command` returns the name of the foreground process in a pane, such as `zsh`, `vim`, `node`, or `python3`. tmux reads this from the pane's TTY, so it reflects the process that currently owns the terminal, not just the shell you launched.

Combined with `display-message -p`, the value prints straight to stdout, which makes it easy to use in scripts or to check a pane quickly. Without `-p`, the value appears in the status line instead.

The same variable also works inside `status-right`, pane border formats, and conditionals like `#{==:#{pane_current_command},vim}`.

## Example

Check what is running in the pane with index 2 of the current window:

```sh
tmux display-message -p -t :.2 '#{pane_current_command}'
```

Example output:

```
node
```

To use it in a script that only acts when a specific editor is open:

```sh
if [ "$(tmux display-message -p -t :.2 '#{pane_current_command}')" = "vim" ]; then
  tmux send-keys -t :.2 ':w' Enter
fi
```

Add this to `~/.tmux.conf` to show the running command in the status bar for every window:

```tmux
set -g window-status-format '#I:#W #{pane_current_command}'
set -g window-status-current-format '#I:#W #{pane_current_command}'
```
