# Show a tmux pane's pid with `display-message`

Each pane runs a process, and its process ID is available as the `#{pane_pid}` format variable. Use `display-message -p` to print it without leaving your current pane.

```sh
tmux display-message -p '#{pane_pid}'
```

Run that from inside the pane you want to inspect and it prints that pane's shell PID. Pass `-t` to query another pane by its target:

```sh
tmux display-message -p -t work:1.2 '#{pane_pid}'
```

Combine it with `ps` to see what the pane is actually running:

```sh
ps -o pid,ppid,command -p "$(tmux display-message -p -t work:1.2 '#{pane_pid}')"
```

This is handy when you need to send a signal to a process inside a pane, attach a debugger, or confirm which PID belongs to a hung shell. The value is the PID of the pane's direct child process, usually the login shell, so a running `vim` or `node` shows up as its child, not as `pane_pid` itself.
