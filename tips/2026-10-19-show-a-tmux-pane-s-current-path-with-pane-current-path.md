# Show a tmux Pane's Current Path With `#{pane_current_path}`

Need to know which directory a pane is in without `cd`-ing or running `pwd`? Query the `pane_current_path` format variable directly.

## Command

```
tmux display-message -p -t {pane} '#{pane_current_path}'
```

## Explanation

`pane_current_path` is a format variable that tmux resolves from the shell process running in the pane. It returns the pane's live working directory, which updates whenever the shell changes directories.

- `display-message -p` prints the expanded value to stdout instead of the status bar, so you can capture it in scripts.
- `-t {pane}` targets a specific pane, such as `work:1.2` or `%5`. Omit `-t` to use the current pane.

This is useful in scripts, status lines, or key bindings that need to open a new window in the same directory.

## Example

List the working directory of every pane in the current session:

```
tmux list-panes -s -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_path}'
```

Or open a new window in the directory of the pane you are in:

```
bind c new-window -c "#{pane_current_path}"
```
