# Jump to a Pane Showing an Error Using Pattern Matching

Quickly find and navigate to panes displaying errors or warnings in their output without manual searching.

## The Command

```
tmux capture-pane -t <pane> -p | grep -E "ERROR|FATAL|Exception" && tmux select-pane -t <pane>
```

## Explanation

Scan a pane's recent scrollback for error keywords and jump to it automatically. This is useful when running multiple parallel processes or monitoring services and you need to find which one failed.

## Example

Create a key binding that checks all panes and jumps to the first one showing an error:

```
bind E run-shell 'for pane in $(tmux list-panes -a -F "#{pane_id}"); do if tmux capture-pane -t "$pane" -p | grep -qE "ERROR|FATAL|Exception|failed"; then tmux select-pane -t "$pane"; echo "Found error in $pane"; break; fi; done'
```

Or create a custom function to highlight error-containing panes:

```
# In your tmux.conf:
bind E run-shell 'tmux list-panes -a -F "#{pane_id}: #{pane_current_command}" | while read line; do pane=${line%:*}; if tmux capture-pane -t "$pane" -p | grep -qE "ERROR|error"; then tmux display-message "Error found in $line"; tmux select-pane -t "$pane"; break; fi; done'
```

This pattern-based search saves time in complex multi-pane setups where you need to locate failing services or tests quickly.
