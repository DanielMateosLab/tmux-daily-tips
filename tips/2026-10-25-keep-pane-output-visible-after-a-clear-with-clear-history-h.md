# Keep Pane Output Visible After a Clear with `clear-history -H`

tmux's `clear-history` command wipes the scrollback buffer for a pane. Sometimes you want to clear the history but keep the most recent output on screen, which is what `clear-history` does by default. The `-H` flag is different: it removes history lines but preserves the visible screen contents exactly as they are.

Use it when you want a clean scrollback for a long-running process without losing the current screen state, such as a log tail or an interactive session you're still reading.

## Command

```
tmux clear-history -H -t {pane}
```

- `-t {pane}` targets a specific pane (omit it to target the current pane).
- `-H` keeps the visible screen intact instead of blanking it.

## Key binding

Add this to `~/.tmux.conf` to clear history from the current pane with a single keystroke:

```tmux
bind-key C-k clear-history -H
```

Reload the config with `prefix` + `:` then `source-file ~/.tmux.conf`, or use the reload binding you already have.

## Example

Suppose you're tailing a log and it has filled the scrollback with thousands of lines you no longer need:

```bash
tail -f /var/log/system.log
```

Press `prefix` + `C-k`. The history above the visible area is discarded, and the lines currently on screen remain where they are. Scrolling up in copy mode now shows only what has arrived since the clear, and you keep the context you were reading.

Compare this with `prefix` + `:` then `clear-history`, which empties both the history and the screen.
