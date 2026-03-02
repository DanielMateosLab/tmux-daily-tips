# Zoom a Pane to Full Screen and Back

## Shortcut

```
Prefix + z
```

(Default prefix is `Ctrl-b`)

## What It Does

Temporarily expands the current pane to fill the entire window. Press the same shortcut again to restore it to its original size and position. The other panes are not destroyed — they're just hidden while the zoom is active.

## Why It's Useful

When you're working in a multi-pane layout but need to focus on one pane — reading a long log, editing a file, or running a test suite — zooming lets you use the full terminal without disrupting your layout.

A zoomed pane shows `[Z]` in the status bar so you always know you're in zoom mode.

## Example Workflow

```bash
# Split into three panes: editor, server, and tests
tmux split-window -h
tmux split-window -v

# You're reviewing test output but the pane is too narrow
# Press Ctrl-b z to zoom the test pane to full screen
# ... read the output comfortably ...
# Press Ctrl-b z again to snap back to your 3-pane layout
```

## Bonus: Zoom-Aware Scripting

You can check if the active pane is zoomed in scripts:

```bash
tmux display-message -p '#{window_zoomed_flag}'
# Returns 1 if zoomed, 0 otherwise
```

This is handy for status bar customizations or scripts that behave differently when a pane is zoomed.
