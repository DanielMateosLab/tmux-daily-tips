# Find Your Last Pane Layout Stripped Back to Its Splits

Run `tmux select-layout` with no layout name after you change panes by hand, and tmux reapplies the window's last layout. Use it to recover a tidy layout after a stray resize or split.

## The command

```
tmux select-layout -E
```

`-E` spreads the panes evenly, similar to `even-horizontal`. Without `-E`, tmux restores the layout the window used before its most recent change. You can also bind it to a key:

```
bind-key Space select-layout -E
```

## Why it helps

Resizing a pane or splitting one shifts every other pane's size. Retyping the previous layout by hand takes effort, and the preset cycle with `Space` jumps to layouts you did not want. `select-layout` with no argument and `-E` both restore a sensible arrangement in one step.

## Example

You have three panes stacked on the left and a wide one on the right. You drag one border by accident and the panes look off. Run:

```
tmux select-layout -E
```

Every pane gets the same size in the window's current arrangement. If you want the exact layout from before the accident, run `tmux select-layout` with no flags first. It tries to restore the previous layout, and `-E` is the fallback when that does not fit.
