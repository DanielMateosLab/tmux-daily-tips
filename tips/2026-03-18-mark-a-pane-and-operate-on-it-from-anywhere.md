# Mark a Pane and Operate on It from Anywhere

## The Shortcut

`Prefix + m` — mark the current pane

## What It Does

Marking a pane sets it as a global reference point you can target from any window or session using `{marked}`. This is incredibly useful when you need to swap, join, or move panes across distant windows without memorizing pane IDs.

A marked pane gets a visual indicator (its border changes) so you always know which one is tagged.

## How to Use It

1. Navigate to the pane you want to mark
2. Press `Prefix + m` to mark it
3. Switch to any other window or session
4. Use the marked pane as a target in commands

## Practical Examples

**Swap a pane with the marked one from anywhere:**

```
# First, mark pane in window 1 with Prefix + m
# Then navigate to window 3, and run:
swap-pane -t {marked}
```

**Join the marked pane into your current window:**

```
# Mark the pane you want to grab, go elsewhere, then:
join-pane -s {marked}
```

**Send the current pane to sit beside the marked one:**

```
join-pane -t {marked}
```

**Clear the mark when you're done:**

```
# Press Prefix + m again on the marked pane, or:
select-pane -M
```

## Why This Matters

Without marks, moving panes between windows requires you to specify session, window, and pane indices like `-t mysession:2.1`. With a mark, you tag the pane visually, walk away, and refer back to it as `{marked}` — no mental bookkeeping required.

Think of it as a clipboard for panes: cut from here, paste over there.
