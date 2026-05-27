# Select Columns with Rectangle (Block) Selection in Copy Mode

Normal copy-mode selection grabs whole lines. But sometimes you only want a *column* of text — say the PID column from `ps`, or an aligned field from a log. Tmux's rectangle selection lets you carve out a block instead of full rows.

## The shortcut

Inside copy mode, after starting a selection:

```
prefix [          # enter copy mode
Space             # start selection (or v in vi mode)
C-v               # toggle rectangle (block) mode
```

The key is `C-v` (Ctrl-v) — it flips the active selection between normal line-wise mode and a rectangular block. Press it again to toggle back.

## How it works

In normal mode, extending the selection down wraps around the ends of lines, so you always capture everything between your start and end points. In **rectangle mode**, the selection is constrained to the horizontal range between your start and end columns — every row is clipped to that same column span, producing a clean vertical block.

This is ideal for fixed-width, column-aligned output where the data you want lines up vertically but is surrounded by junk you don't.

## Concrete example

You run `ps aux` and want just the PID column (roughly columns 9–14):

```
USER   PID  %CPU %MEM   COMMAND
root     1   0.0  0.1   /sbin/init
dan    842   1.2  3.4   tmux
dan    901   0.0  0.5   zsh
```

1. `prefix [` to enter copy mode.
2. Move the cursor to the start of the first PID (`1`).
3. Press `Space` to begin selecting.
4. Press `C-v` to switch to rectangle mode.
5. Move down and right to cover just the PID digits across all rows.
6. Press `Enter` to copy.

Your buffer now contains only:

```
  1
842
901
```

…with no USER or COMMAND text dragged along.

## Quick tip

Combine it with `copy-pipe` to send the block straight to another tool:

```
1            # select a column of numbers
C-v          # rectangle mode
# extend selection, then:
:           # command prompt? no — instead bind a key
```

Or bind it directly in `.tmux.conf` so a block selection pipes to `awk`/`paste`:

```
bind -T copy-mode-vi C-v send -X rectangle-toggle
```

Rectangle mode turns copy mode into a tiny column extractor — no mouse, no `cut -c`, no re-running the command.
