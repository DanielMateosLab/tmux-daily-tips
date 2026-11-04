# Show a tmux window's pane count in its status bar with ...

Hmm, that's already covered several times. Here's a different one instead.

# Find which pane is running a given command with `list-panes -f`

The `-f` flag on `list-panes` takes a format filter. It prints only the panes where the expression evaluates to true, so you can locate a pane by its running command without scanning the list by eye.

```sh
tmux list-panes -a -f '#{==:#{pane_current_command},vim}' -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_path}'
```

The filter compares `pane_current_command` against `vim` across every session with `-a`. Each match prints its target address and working directory, so you can feed the address straight into `select-pane -t`:

```sh
target=$(tmux list-panes -a -f '#{==:#{pane_current_command},vim}' -F '#{session_name}:#{window_index}.#{pane_index}' | head -n1)
tmux switch-client -t "$target"
```

Swap `vim` for `node`, `ssh`, or any process name shown by `#{pane_current_command}`. Use `#{m:*ssh*,#{pane_current_command}}` for a glob match instead of exact equality.
