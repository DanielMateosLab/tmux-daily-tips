# Filter choose-tree with -f for Instant Session Search

## Shortcut / Command

```
tmux choose-tree -Zs -f '#{m:*api*,#{session_name}}'
```

Or bind it to a key in `~/.tmux.conf`:

```
bind S choose-tree -Zs -f '#{m:*api*,#{session_name}}'
```

## Explanation

`choose-tree` already lets you browse sessions, windows, and panes interactively, but when you have dozens of sessions the list becomes a wall of names. The `-f` flag accepts a tmux format expression and pre-filters the tree to only entries where the expression evaluates to true (non-zero, non-empty).

Combined with format comparators like `#{m:pattern,string}` (glob match) or `#{C:text}` (search pane contents), you can jump straight to the subset you care about — sessions matching a project prefix, windows running a specific command, or panes whose visible buffer contains a search term.

Useful comparators inside `-f`:

- `#{m:*pattern*,#{session_name}}` — glob match session name
- `#{m/r:^feat-,#{window_name}}` — regex match window name
- `#{C:TODO}` — panes whose current content contains "TODO"
- `#{==:#{pane_current_command},vim}` — panes running vim

## Example

Pre-filter to only windows currently running a long-running server process:

```
tmux choose-tree -Zw -f '#{||:#{==:#{pane_current_command},node},#{==:#{pane_current_command},python}}'
```

Or, interactively from the prompt (`prefix` + `:`):

```
:choose-tree -Zs -f '#{m:*client-*,#{session_name}}'
```

Only sessions whose names match `client-*` appear, and `Enter` jumps straight there — no scrolling through the full tree.
