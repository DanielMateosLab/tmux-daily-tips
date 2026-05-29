# Renumber Windows to Close Gaps with `move-window -r`

After you close a few windows, your indexes end up scattered — `0`, `3`, `7` — which makes jumping by number awkward. The `-r` flag on `move-window` renumbers every window in the current session sequentially, closing the gaps.

## The command

```
tmux move-window -r
```

Or from inside tmux, at the command prompt (`prefix` + `:`):

```
:move-window -r
```

Bind it to a key for one-press cleanup. Add to `~/.tmux.conf`:

```
bind R move-window -r \; display-message "windows renumbered"
```

Now `prefix` + `R` tidies the whole session.

## Example

You started with four windows and killed a couple in the middle:

```
0: vim    3: logs    5: shell    8: htop
```

After `prefix` + `R`:

```
0: vim    1: logs    2: shell    3: htop
```

The order is preserved, the gaps are gone, and `prefix` + `1`/`2`/`3` now land where you expect.

## Make it automatic

If you'd rather never see gaps in the first place, enable automatic renumbering whenever a window closes:

```
set -g renumber-windows on
```

With this set, killing window `3` immediately shifts `5` and `8` down to `3` and `4` — no manual cleanup needed. The manual `move-window -r` is still handy for sessions where you keep `renumber-windows off` but occasionally want a one-time tidy.

## Why it's useful

Sequential indexes keep `prefix` + number navigation fast and predictable, especially in long-lived sessions where you open and close many windows over a workday.
