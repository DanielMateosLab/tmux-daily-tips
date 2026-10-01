# Explore Pane Scrollback in an Interactive Pager

## Command
```
tmux capture-pane -p -S -100 -t <pane> | less -R
```

## What It Does
Captures recent pane output and pipes it to `less` for interactive exploration. The `-S -100` grabs the last 100 lines; the `-R` flag in `less` preserves ANSI color codes, making colored output readable. Navigate with arrows, search with `/`, quit with `q`.

## Why It's Useful
- Search, scroll, and filter pane output without entering copy mode
- Use familiar pager keybindings instead of tmux's copy mode
- Combine scrollback with Unix tools (grep, awk, sed)
- Quick inspection without disrupting the live pane or layout

## Examples

**Browse the last 50 lines with colors preserved:**
```
tmux capture-pane -p -S -50 -t 0 | less -R
```

**Search pane output for errors:**
```
tmux capture-pane -p -t mywindow | grep ERROR
```

**View full scrollback history:**
```
tmux capture-pane -p -S 0 -t pane | less -R
```

**Combine multiple panes' output into one view:**
```
tmux list-panes -t window -F '#{pane_id}' | \
  xargs -I {} tmux capture-pane -p -t {} | less -R
```

**Extract lines matching a pattern:**
```
tmux capture-pane -p -t pane | grep "error" | tee errors.log
```

## Notes
- Use `-S 0` to capture from the start of scrollback (slower for large buffers)
- The `-e` flag in capture-pane preserves ANSI codes; pair it with `less -R` to render colors
- Useful for occasional inspection; enter copy mode for frequent scrollback work
