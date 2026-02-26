# Quick-Jump to Any Pane with `display-panes`

## The Shortcut

**Prefix + q** (default binding for `display-panes`)

## What It Does

When you have multiple panes open, it can be hard to remember which pane number is which. `display-panes` briefly flashes a large overlay number on each pane. While the numbers are displayed, press the corresponding digit to instantly jump to that pane.

This is far faster than cycling through panes with `Prefix + o` when you have 4+ panes open.

## Basic Usage

1. Press `Prefix + q` — large numbers appear overlaid on each pane
2. Press `0`, `1`, `2`, etc. to jump to that pane
3. If you do nothing, the numbers disappear after a timeout

## Tuning the Display Duration

The default timeout is 500ms, which can feel rushed. Increase it so you have more time to read the numbers and choose:

```bash
# Give yourself 2 seconds to pick a pane
tmux set -g display-panes-time 2000
```

Add this to your `~/.tmux.conf` to make it permanent:

```
set -g display-panes-time 2000
```

## Customizing the Colors

You can make the overlay numbers easier to read:

```bash
# Color for the active pane number
set -g display-panes-active-colour red

# Color for inactive pane numbers
set -g display-panes-colour blue
```

## Jumping to Panes 10+

By default, `display-panes` only handles single-digit input (0–9). If you have 10+ panes, you can bind a custom key to prompt for a pane number:

```bash
bind-key Q command-prompt -p "jump to pane:" "select-pane -t '%%'"
```

Now `Prefix + Q` will prompt you to type any pane number and hit Enter.

## When to Use This

- You have 3+ panes and need to reach a specific one quickly
- You've rearranged panes and lost track of the numbering
- You want a visual map of your current layout before acting on a pane
