# Kill All Panes Except the Current One with kill-pane -a

Clean up your workspace by closing all other panes in a window instantly.

## Command

```
kill-pane -a
```

## Explanation

The `-a` (all) flag closes every pane in the current window except the one you're actively using. It's invaluable when you've been running multiple debug or test sessions and want to collapse back to a single pane without killing the whole window.

## Example

You're working with 3 panes:
- Pane 0: Your editor (active)
- Pane 1: Running tests
- Pane 2: Monitoring logs

With Pane 0 active, run:

```
kill-pane -a
```

Now only Pane 0 remains; Panes 1 and 2 are closed instantly.

## Quick Binding

Add this to `~/.tmux.conf` for easy access:

```
bind x kill-pane -a
```

Then press `Prefix x` to close all but the current pane.

## Related Commands

- `kill-pane -t 1` — kill a specific pane by index
- `kill-window` — close the entire window (all panes)
- `kill-session` — close the entire session
