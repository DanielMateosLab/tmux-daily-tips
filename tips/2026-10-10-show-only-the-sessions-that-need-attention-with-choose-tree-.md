# Show Only the Sessions That Need Attention with `choose-tree -f`

Skip the scrolling. Open the session tree with a filter applied so only matching sessions or windows are listed, and jump straight to the one you need.

## The Shortcut

- `prefix` + `s` opens the session tree (`choose-tree -Zs`).
- Inside it, `/` starts a search and filters the list as you type.

`choose-tree` also takes a `-f` filter flag, which lets you open the tree already narrowed down. Use it from a bound key or the command prompt:

```
tmux choose-tree -Zs -f '#{m:*api*,#{session_name}}'
```

The filter is a format expression. Only items where it evaluates true are shown.

## Why It Helps

On a machine with dozens of sessions and windows, the default tree is noisy. A filter lets you:

- Show only sessions whose name matches a project
- Show only windows currently running a particular command
- Show only panes with activity flagged

Because the filter is a normal format expression, you can combine any format variables tmux exposes.

## Example: A Bound Key for Build Windows

Add this to `~/.tmux.conf` to open a tree showing only windows whose name starts with `build-`:

```
bind B choose-tree -Zw -f '#{m:build-*,#{window_name}}'
```

Now `prefix` + `B` shows only build windows. Press `Enter` to jump to one, or `Escape` to close.

## Example: Show Only Flagged Windows

To list only windows that have an activity alert:

```
bind A choose-tree -Zw -f '#{||:#{window_activity_flag},#{window_bell_flag}}'
```

Reload with `prefix` + `:` then `source-file ~/.tmux.conf`.
