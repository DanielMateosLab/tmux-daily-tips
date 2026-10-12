# Show a pane's running command at a glance with `list-panes -F`

Tmux tracks the foreground command of every pane. Use `#{pane_current_command}` in a `list-panes` format string to print that name for each pane, without switching windows or reading scrollback.

## The command

```sh
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}'
```

The `-a` flag lists panes across all sessions and windows. The format string expands each variable per pane, so every line shows one pane's address and the program it runs.

## Why it helps

A window name can hide what runs inside it, and `pane_current_command` reports the process tmux sees in the foreground. A pane named `dev` might run `vim`, `node`, or a plain shell. One command shows all of them, which helps when you return to a session after a long gap and want to find the pane running a server or editor.

## Example

Suppose you have a session `work` with three panes running an editor, a dev server, and a shell:

```sh
tmux list-panes -s -t work -F '#{pane_index} #{pane_current_command}'
```

Output:

```
0 nvim
1 node
2 zsh
```

Pipe the output to `grep` to find a specific process, or bind the command to a key with `display-message` for a quick overlay in the status bar.
