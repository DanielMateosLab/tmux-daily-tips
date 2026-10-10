# Show Only the Sessions That Need Attention with `choose-tree -f`

Running `choose-tree` shows every session, window, and pane. When you have many sessions, the ones that matter are buried in the list. The `-f` flag takes a filter expression, so you can show only the entries that meet a condition, such as sessions with unread activity or windows with a bell.

## The Command

```
tmux choose-tree -s -f '#{?session_alert,1,0}'
```

- `-s` opens the session tree.
- `-f` applies a format-based filter. An entry is shown only when the expression evaluates to a non-zero value.
- `#{session_alert}` is set when a window in the session has an alert, such as activity, silence, or a bell.

## Explanation

`choose-tree` accepts `-f` to filter items before they appear in the list. The filter is a format string, so any format variable works. The `#{?cond,yes,no}` conditional makes it easy to write a boolean check.

Some useful filters:

| Goal | Filter |
|------|--------|
| Sessions with alerts | `#{?session_alert,1,0}` |
| Windows with a bell | `#{?window_bell_flag,1,0}` |
| Windows with activity | `#{?window_activity_flag,1,0}` |
| Sessions that are attached elsewhere | `#{?session_attached,1,0}` |

Combine the tree view with a key binding so you can open the filtered view on demand:

```
bind A choose-tree -s -f '#{?session_alert,1,0}'
```

Press `prefix` then `A` to see only the sessions that need your attention. Select one with the arrow keys and press `Enter` to jump to it.

## Example

Suppose you run three long builds in separate sessions and one has finished with a bell. Your `choose-tree` normally lists all three plus your idle sessions. With the filter, only the session that rang the bell appears:

```
$ tmux new -d -s build-a 'make; sleep 999'
$ tmux new -d -s build-b 'make; sleep 999'
$ tmux new -d -s idle
$ tmux choose-tree -s -f '#{?session_alert,1,0}'
```

Make sure `monitor-bell` is on so the bell raises the alert flag:

```
set -g monitor-bell on
```
