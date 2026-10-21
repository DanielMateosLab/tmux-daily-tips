# Show a tmux pane's pane_pid to find its root process

Each pane runs a process tree, and the pane's root process has a PID you can read without guessing. Use `#{pane_pid}` in `display-message` to see the shell PID for the active pane, which is handy when you need to `kill`, `strace`, or `ps` a specific pane's job from outside tmux.

## Command

```
tmux display-message -p '#{pane_pid}'
```

- `-p` prints the result to stdout instead of the status bar.
- `#{pane_pid}` expands to the process ID of the program started in the pane (usually your login shell).

To read it for a specific pane, pass a target with `-t`:

```
tmux display-message -p -t %3 '#{pane_pid}'
```

Pane IDs (`%N`) are stable for the life of the pane, so they are safer than indexes when a script runs against a pane that might move.

## Why it helps

Sometimes you want to act on the process running in a pane without attaching to it. For example, you may want to send a signal to a hung job, or attach a debugger to it. Getting the PID from tmux avoids hunting through `ps` output for the right shell.

## Example

Find the shell PID for the current pane, then inspect its children:

```
tmux display-message -p '#{pane_pid}'
# 48213

ps -o pid,ppid,command --ppid 48213
#   PID  PPID COMMAND
# 48977 48213 node server.js
```

Or bind a key that copies the PID to your clipboard for quick reuse:

```
bind P run-shell "tmux display-message -p '#{pane_pid}' | pbcopy" \; display-message "pane pid copied"
```

Use this with `ps --ppid` or `pstree -p` to see exactly what a pane is running.
