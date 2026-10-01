# Capture Panes with True Color Output

## Shortcut
```bash
tmux capture-pane -t pane -p -C
```

## Explanation
By default, `capture-pane` outputs pane content with reduced color information. The `-C` flag preserves RGB/true color codes in the captured output, making it useful for saving terminal sessions with accurate color representation or piping to tools that need the full color palette.

## Example

Capture a pane with colors intact and save to a file:
```bash
tmux capture-pane -t mywindow -p -C > pane_output.txt
```

Capture and pipe to `less` for interactive viewing with colors preserved:
```bash
tmux capture-pane -t 0 -p -C | less -R
```

Use in a script to extract colored output from a build process:
```bash
tmux capture-pane -t build-window -p -C -S -100 | grep -i error
```

Without `-C`, ANSI color codes are simplified to 256-color mode or worse. With `-C`, the full RGB information is preserved, which matters when documenting terminal sessions or forwarding colored output to external tools that support true color.
