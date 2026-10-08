# Use display-message to preview and test format strings

## Command

```
tmux display-message -p "#{format_string}"
```

## Explanation

`display-message` outputs text to the status bar (or `-p` prints to stdout). Use it to test format strings, debug variables, and preview dynamic content before using it in bindings, status bar, or scripts. This is invaluable when building complex format strings with conditionals and substitutions.

## Example

Preview what your next-window shortcut will display:

```bash
tmux display-message -p "Window: #{window_index} (#{window_name}) | Panes: #{window_panes}"
```

Test a conditional format string:

```bash
tmux display-message -p "#{?#{pane_in_mode},In copy mode,Command mode}"
```

Build a pane identifier string for automation:

```bash
tmux display-message -p "#{session_name}:#{window_index}.#{pane_index}"
```

Use in a binding to show pane info on demand:

```bash
bind S display-message -p "Pane: #{pane_pid} | Dir: #{pane_current_path} | Size: #{pane_width}x#{pane_height}"
```

Create a "status snapshot" showing multiple panes:

```bash
tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} -> #{pane_title}" | \
  xargs -I {} tmux display-message -p "{}"
```

Once your format string works, copy it into status-bar definitions, keybindings, or send-keys commands with confidence.
