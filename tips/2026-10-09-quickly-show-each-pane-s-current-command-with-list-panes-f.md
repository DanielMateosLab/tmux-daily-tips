# Quickly Show Each Pane's Current Command with `list-panes -F`

Use `#{pane_current_command}` in a `list-panes` format string to see what every pane is running, without switching focus.

## The command

```sh
tmux list-panes -s -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}'
```

- `-s` lists panes across every window in the current session.
- `-F` takes a format string. `#{pane_current_command}` expands to the foreground process name in that pane, such as `zsh`, `vim`, `node`, or `ssh`.

## Why it helps

Before you send keys or kill something, you often want to know whether a pane is idle at a shell prompt or busy with a long-running process. Scanning the status bar or cycling through windows is slow. One `list-panes` call gives you the answer for the whole session in one line per pane.

## Example

Suppose a session has three windows, and you want to find the pane running `node` before you restart a dev server:

```sh
tmux list-panes -s -F '#{window_index}.#{pane_index} #{pane_current_command}' | grep node
```

Output:

```
1.0 node
2.1 node
```

You can now target one directly with `tmux send-keys -t 2.1 C-c`.

## Bind it to a key

Add this to `~/.tmux.conf` to show the list in a popup when you press `prefix` then `P`:

```tmux
bind P display-popup -E "tmux list-panes -s -F '#{window_index}.#{pane_index} #{pane_current_command}' | less"
```

Reload with `tmux source-file ~/.tmux.conf`, then press `prefix` `P` to view the list. Press `q` to close the popup.
