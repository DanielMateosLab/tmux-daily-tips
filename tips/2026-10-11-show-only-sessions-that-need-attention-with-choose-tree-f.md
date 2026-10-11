# Show Only Sessions That Need Attention with `choose-tree -f`

Most of the time you don't want to scan every session in `choose-tree`. The `-f` flag takes a filter expression, so you can restrict the tree to just the sessions, windows, or panes that match a condition, such as an active bell, unseen activity, or a running command you care about.

## The Shortcut

From the prefix menu (`prefix` + `w`), the default `choose-tree` already supports filtering with `f`. To bind a dedicated key that opens the tree pre-filtered to sessions with alerts:

```tmux
bind-key A choose-tree -s -f '#{||:#{session_alert},#{session_activity_flag}}'
```

- `-s` starts the tree at session level.
- `-f` applies a format-based filter; only items where the expression evaluates to true are shown.
- `session_alert` is nonzero when any window in the session has a bell, activity, or silence flag set.

## Why It Helps

When you run many long jobs across sessions, the signal you need is "which one finished or is waiting on me." A filtered tree answers that in one keystroke, instead of cycling through every session with `prefix` + `)`.

## Example

Suppose you have sessions `build`, `logs`, and `scratch`, and only `build` has a window that rang the bell after a compile finished. Press `prefix` + `A` and the tree shows only `build`. Press `Enter` to jump straight to it.

To narrow further to windows instead of sessions, use `-w` and filter on `#{window_bell_flag}`:

```tmux
bind-key W choose-tree -w -f '#{window_bell_flag}'
```

Pair this with `monitor-bell on` and `bell-action any` so the flags actually get set when a background job rings.
