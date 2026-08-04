# Extract Specific Lines from Pane Scrollback with capture-pane

Grab the last N lines, search for patterns, or export specific sections from a pane's history without entering copy mode.

## Command

```
tmux capture-pane -p -S -20              # last 20 lines
tmux capture-pane -p -S -100 -E -1       # lines 100 to last
tmux capture-pane -p | grep "pattern"    # search scrollback
tmux capture-pane -p -J > history.txt    # export joined text
```

## Explanation

- `-p` outputs to stdout instead of saving to a buffer
- `-S N` starts from line N (negative counts from the end)
- `-E N` ends at line N (negative counts from the end)
- `-J` joins wrapped lines so text flows naturally
- Pipe to `grep`, `awk`, `sed` to filter and process

## Example

Get the last error from a background job pane:

```
tmux capture-pane -p -S -200 | grep "ERROR" | tail -1
```

Extract all database queries executed:

```
tmux capture-pane -p -t mywindow | grep "SELECT\|INSERT"
```

Save an entire pane's output to review later:

```
tmux capture-pane -p -S -5000 -J > debug_log.txt
```

Useful for auditing, debugging, and extracting info without switching to copy mode.
