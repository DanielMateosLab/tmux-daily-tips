# Use command substitution in send-keys to execute shell commands based on tmux state

When sending commands to a pane, you can use shell command substitution `$()` with `tmux` subcommands to build dynamic commands that adapt to the current session, window, or pane state.

## Command

```sh
tmux send-keys -t target "command $(tmux display-message -p 'format-string')" Enter
```

## Explanation

`tmux display-message -p` prints format variables without displaying them on screen. Wrap it in `$()` within `send-keys` to inject dynamic values into the command you're sending. This lets you reference pane directories, window indices, session names, or any other format variable directly in the executing command.

## Example

Navigate to a pane's current directory from another pane:

```sh
tmux send-keys -t .1 "cd $(tmux display-message -p -t .0 '#{pane_current_path}')" Enter
```

Copy a pane's scrollback to a timestamped file in the pane's working directory:

```sh
tmux send-keys -t .1 "tmux capture-pane -t .0 -p > $(tmux display-message -p -t .0 '#{pane_current_path}')/capture-$(date +%s).txt" Enter
```

Run a command on the active pane's hostname (if set as a window name):

```sh
tmux send-keys -t .1 "ssh $(tmux display-message -p '#{window_name}') 'uname -a'" Enter
```

This eliminates manual variable passing and keeps commands synchronized with tmux's live state.
