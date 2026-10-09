# Quickly list every pane's working directory with `list-panes -F`

Run `tmux list-panes -a -F` with a format string to print one line per pane, showing the session, window, pane, and the directory each pane is in. You don't need to switch to or inspect any pane.

## Command

```sh
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}  #{pane_current_path}'
```

- `-a` lists panes across all sessions, not just the current one.
- `-F` takes a format string. `#{session_name}`, `#{window_index}`, `#{pane_index}`, and `#{pane_current_path}` are format variables that tmux fills in for each pane.

## Example

With three panes open across two sessions, the output looks like this:

```
work:0.0  /Users/dani/eleva/backend
work:0.1  /Users/dani/eleva/backend/logs
notes:1.0  /Users/dani/Documents/notes
```

To find the pane that is already in a project directory, filter the output with `grep`:

```sh
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}  #{pane_current_path}' | grep eleva
```

This prints only the panes whose working directory contains `eleva`. Copy the address from the first column into `tmux select-pane -t` or `tmux switch-client -t` to jump straight there.
