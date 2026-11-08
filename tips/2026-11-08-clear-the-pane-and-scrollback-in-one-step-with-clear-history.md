# Clear the pane and scrollback in one step with `clear-history` alongside a shell reset

Many people run `clear` and then wonder why scrollback still contains the old output. The `clear` command only wipes the visible screen. To drop the history as well, tmux's `clear-history` command does it directly, and you can bind it to a key so it's a single press.

## The command

```
tmux clear-history -t <pane>
```

Run inside a pane with no target, it acts on the current pane.

## Why it's useful

- `clear` in the shell sends a screen-clear sequence. Scrollback is still stored by tmux, so you can scroll back and see everything.
- `clear-history` discards the stored scrollback for the target pane, leaving the visible content alone.
- Combining the two gives a true "fresh start" without closing the pane.

## Bind it to a key

Add this to `~/.tmux.conf`:

```
bind C-k clear-history
```

Then reload with `tmux source-file ~/.tmux.conf` (or the tip on reloading config).

Press `prefix` then `Ctrl-k` to wipe the current pane's scrollback instantly.

## Example

You've been running a noisy build and want a clean scrollback before the next run:

```
$ make build          # produces thousands of lines
$ prefix C-k         # scrollback is cleared
$ make test           # only test output is now in history
```

The visible screen keeps its current contents, so press `Enter` or run `clear` afterward if you also want the screen blank.
