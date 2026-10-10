# Show Only the Sessions That Need Attention with `choose-tree -f`

Once you run many tmux sessions, the full session list gets noisy. The `choose-tree` filter lets you narrow the tree view with a format expression, so you see only the sessions that matter right now, such as those with unseen activity or an active bell.

## The command

```
tmux choose-tree -s -f '#{?session_alert,1,0}'
```

Or bind it to a key in your config:

```
bind T choose-tree -s -f '#{||:#{session_alert},#{session_activity_flag}}'
```

- `-s` starts the tree in session mode.
- `-f` takes a format string. Only items where the expression evaluates to a non-zero value are shown.
- `session_alert` is true when any window in the session has a bell, activity, or silence alert pending.
- `session_activity_flag` is true when a window in the session has unseen activity.

## How it works

The filter is evaluated for each session. Sessions where the expression is `0` or empty are hidden, so the tree shows only the flagged sessions. Pressing `Enter` on an entry switches to that session and clears its alert state, so the list shrinks as you handle each one.

Combine it with `monitor-activity on` or `monitor-bell on` in the relevant windows so that the flags get set in the first place.

## Example

Set up a long-running build in one session and monitor it:

```
tmux new-session -d -s build 'make all; tmux display-message "build done"'
tmux set-option -t build monitor-activity on
```

Then, from any other session, press your binding. The tree shows only `build` (and any other session with pending alerts). Select it with the arrow keys and press `Enter` to jump there.
