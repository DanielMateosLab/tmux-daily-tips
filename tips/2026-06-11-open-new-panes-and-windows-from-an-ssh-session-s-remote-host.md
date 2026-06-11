# Open New Panes and Windows From an SSH Session's Remote Host

**Command:** `split-window "ssh myhost"` — or better, bind a key:

```tmux
bind-key S command-prompt -p "ssh to:" "split-window -h 'ssh %%'"
```

When you work on remote machines a lot, manually typing `ssh somehost` in every new pane gets old fast. You can teach tmux to spawn panes that immediately run a command — like an SSH connection — instead of a plain shell.

## How it works

Both `split-window` and `new-window` accept a shell command as their final argument. The pane runs that command directly, and when the command exits (e.g., you log out of SSH), the pane closes.

```sh
# Split horizontally, already connected to the remote host
tmux split-window -h "ssh web-01"

# New window named after the host
tmux new-window -n web-01 "ssh web-01"
```

## A smarter binding: reuse the current pane's SSH target

If your current pane is running SSH, you can grab the target from the pane's running command and open a sibling connection:

```tmux
bind-key % if-shell -F "#{m:ssh*,#{pane_current_command}}" \
    "split-window -h \"#{pane_start_command}\"" \
    "split-window -h"
```

With this, pressing `prefix %` in an SSH pane (started via `split-window "ssh host"`) opens another pane connected to the same host, while plain shell panes split normally.

## Keep the pane around after disconnect

Since the pane dies when SSH exits, flaky connections can be annoying. Combine with `remain-on-exit` so you can respawn instead of losing the layout:

```sh
tmux split-window -h "ssh web-01" \; set-option -p remain-on-exit on
```

Then `prefix` + `respawn-pane` reconnects in place when the link drops.

## Example workflow

```sh
# One command from your local shell: monitoring dashboard for 2 servers
tmux new-session -d -s servers "ssh web-01"
tmux split-window -h -t servers "ssh web-02"
tmux attach -t servers
```

You land in a session with both servers already connected, side by side — no typing `ssh` twice.
