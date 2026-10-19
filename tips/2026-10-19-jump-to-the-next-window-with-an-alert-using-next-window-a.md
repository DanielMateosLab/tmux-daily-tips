# Jump to the Next Window with an Alert Using `next-window -a`

Need to find the window that just finished a build, printed output, or rang the bell? `next-window -a` cycles only through windows that have activity flags set, so you skip straight to the one that needs attention.

## Command

```
tmux next-window -a
```

Bind it to a key in your config to use it interactively:

```
bind-key N next-window -a
```

Press `prefix` + `N` to jump to the next window with activity, bell, or silence flags set. Windows with no flags are skipped.

## Why it helps

With many windows open, `next-window` (`prefix` + `n`) walks through every window in order. When a long-running job finishes in window 7 while you're working in window 2, you'd have to check each window one by one. The `-a` flag filters that walk down to the windows that actually changed.

Flags are cleared once you visit the window, so repeated presses move forward through each alerting window in turn.

## Example

Start a long task in window 3, then switch to another window:

```
# In window 3
make test && echo "tests done"
```

Switch to window 1 and keep working. When `make test` finishes and prints output, window 3 gets an activity flag. From window 1, press `prefix` + `N` and tmux jumps directly to window 3.

For the flags to appear, enable monitoring first:

```
set-option -g monitor-activity on
set-option -g visual-activity on
```
