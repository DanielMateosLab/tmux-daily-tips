# Show a tmux Pane's Session Name in the Pane Border with `#{session_name}` in `pane-border-format`

Pane borders can display format variables, and `#{session_name}` is useful when you run several sessions side by side or over SSH and need to confirm which session a pane belongs to.

Set the `pane-border-format` option and enable the border status line:

```
set -g pane-border-status top
set -g pane-border-format " #{session_name} | #{pane_index}: #{pane_current_command} "
```

- `pane-border-status top` draws a status line along the top edge of each pane. Use `bottom` if you prefer it there.
- `pane-border-format` takes any format string. `#{session_name}` is the session the pane belongs to, `#{pane_index}` is its number, and `#{pane_current_command}` is the foreground process.

To apply it immediately without restarting, run:

```
tmux set -g pane-border-status top
tmux set -g pane-border-format " #{session_name} | #{pane_index}: #{pane_current_command} "
```

Or add the two lines to `~/.tmux.conf` and reload with `tmux source-file ~/.tmux.conf`.

**Example:** You have a `work` session with an editor and a log tail side by side. Each pane's top border now reads something like ` work | 0: nvim ` and ` work | 1: tail `. If you attach to a second session later, its panes show their own session name, so you can tell at a glance which session each pane came from when you break or join panes between windows.

Use `set -g` for a global setting. Use `set -w` if you want the border format only in the current window.
