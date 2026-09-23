# Quick Focus on Error Panes Using Pattern Matching

## Command
```
tmux select-pane -t "$(tmux list-panes -F '#{pane_title}' -f '#{m:*error*,#{pane_title}}' -a | head -1)"
```

## Explanation
When you're running multiple processes in different panes, errors can appear in unexpected places. This pattern uses `list-panes` with format filtering (`-f`) to search for a pane whose title contains "error", then immediately jumps to that pane. The `-F` flag specifies which format to output (pane title), and `-a` searches across all windows.

You can bind this to a key for instant error navigation:
```
bind-key e run-shell 'tmux select-pane -t "$(tmux list-panes -F "#{pane_index}" -f "#{m:*ERROR*,#{pane_title}}" | head -1)"'
```

## Practical Example
Set pane titles when launching processes:
```
tmux send-keys -t window:0.0 'npm start' Enter
tmux send-keys -t window:0.1 'npm test' Enter
tmux send-keys -t window:0.2 'npm lint' Enter

tmux select-pane -t window:0.2 -T "ERROR-LOG"
```

Now press `Prefix + e` to jump directly to the pane titled "ERROR-LOG". Useful in development environments where builds, tests, or linters output errors in dedicated panes.
