# Close all other windows and focus on the current one

## The shortcut

```
kill-window -a
```

Or bind it to a key:

```
bind-key q kill-window -a
```

## The explanation

When you have many windows open and want to declutter, `kill-window -a` closes every window *except* the active one. This is faster than navigating to each window and closing it individually. It's the window-level equivalent of closing all panes except the current one.

You can also target a specific window without switching to it:

```
kill-window -a -t mywindow
```

This closes all windows *except* `mywindow`, regardless of which window you're currently in.

## Example

```
# You have windows: 0:editor  1:server  2:logs  3:test
# You're in window 3

kill-window -a
# Now only window 3 remains

# Or target without switching:
kill-window -a -t 1:server
# Closes 0, 2, 3; keeps 1:server alive
```

Use this when a session gets cluttered and you want a fresh start with just one or two critical windows.
