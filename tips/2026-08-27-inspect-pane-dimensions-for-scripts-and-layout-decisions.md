# Inspect Pane Dimensions for Scripts and Layout Decisions

Programmatically access pane sizes and properties using `list-panes` with format strings to make script decisions.

**Command:**
```
tmux list-panes -t <session>:<window> -F "#{pane_index}: #{pane_width}x#{pane_height}"
```

**Explanation:**
The `-F` flag extracts specific pane data without switching panes. Useful for scripts that need to verify dimensions before resizing, detect layout changes, or validate splits.

**Example:**
```
# Get all pane dimensions in current window
tmux list-panes -F "#{pane_index}: #{pane_width}x#{pane_height}"
# Output: 0: 80x24
#         1: 80x24

# Find panes narrower than 40 columns
tmux list-panes -F "#{pane_index} #{pane_width}" | awk '$2 < 40 {print $1}'

# Check if current window has enough space for a 3-way split
width=$(tmux list-panes -F "#{pane_width}" | head -1)
[ $width -ge 120 ] && tmux split-window -h -t current -p 33
```

**Format Variables:**
- `#{pane_width}`: Columns
- `#{pane_height}`: Rows  
- `#{pane_index}`: Number
- `#{pane_active}`: 1 if focused
- `#{pane_dead}`: 1 if dead
