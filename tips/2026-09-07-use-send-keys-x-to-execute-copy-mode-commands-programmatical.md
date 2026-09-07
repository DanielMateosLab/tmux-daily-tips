# Use `send-keys -X` to Execute Copy-Mode Commands Programmatically

`send-keys -X` runs copy-mode commands (like `select-all`, `copy-selection`, or `search-forward`) directly on a pane without manually entering copy-mode. Useful for automating text selection and building tmux macros.

## Keybinding: Quick Select-All and Copy

```tmux
bind C-c send-keys -X select-all \; send-keys -X copy-selection
```

Now `Prefix Ctrl-C` selects all pane output and copies it to the clipboard in one keystroke.

## Common Copy-Mode Commands

- `select-all` — highlight the entire scrollback
- `copy-selection` — copy selected text to clipboard
- `copy-selection-and-cancel` — copy and exit copy-mode
- `search-forward pattern` — search within the pane
- `bottom-line` — jump to the end of scrollback

## Practical Examples

Copy the last 50 lines to clipboard:
```bash
tmux send-keys -X -N 50 copy-selection
```

Jump to a search result:
```bash
tmux send-keys -X search-forward "ERROR"
```

Automate selecting text for a script:
```bash
tmux send-keys -X select-all \; send-keys -X copy-selection-and-cancel
```

## Why It's Better Than Manual Copy-Mode

Without `-X`, you'd press `[`, navigate, select, copy, and exit. With `-X`, one command does it all—perfect for scripts, quick macros, and log analysis workflows.
