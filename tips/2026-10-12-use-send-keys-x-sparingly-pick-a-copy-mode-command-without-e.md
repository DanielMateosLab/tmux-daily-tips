# Use `send-keys -X` Sparingly: Pick a Copy-Mode Command Without Entering Copy Mode

Most copy-mode commands are normally triggered by pressing keys while you're in copy mode. You can send those same commands directly to a pane with `send-keys -X`, which is handy for scripts and keybindings that need to drive scrollback without a human at the keyboard.

Note that `-X` only works for pane copy-mode commands, so the target pane must already be in copy mode. Entering copy mode first is the step most people forget.

## The Pattern

```
tmux send-keys -t <target> -X <copy-mode-command>
```

The `-X` flag tells tmux to interpret the argument as a copy-mode command name (such as `cancel`, `page-up`, `search-backward`) rather than as literal keystrokes.

## Example: Scroll a Background Pane and Jump to the Top

Suppose a build log runs in pane `%3`, and you want to inspect its scrollback from your current pane without switching focus.

```sh
# Enter copy mode in the target pane (no focus change)
tmux copy-mode -t %3

# Jump to the top of the history
tmux send-keys -t %3 -X history-top

# Search backward for an error keyword
tmux send-keys -t %3 -X search-backward "error"

# Exit copy mode when finished
tmux send-keys -t %3 -X cancel
```

## Bind It to a Key

Wrap the sequence in a binding so one keypress jumps a log pane to its most recent error:

```tmux
bind-key E copy-mode -t %3 \; \
  send-keys -t %3 -X history-bottom \; \
  send-keys -t %3 -X search-backward "error"
```

## Tips

- Run `tmux list-commands | grep copy-mode` or see `man tmux` under "Copy mode" for the full list of `-X` command names.
- If the pane isn't in copy mode, `-X` commands fail silently in many versions, so call `copy-mode -t` first.
- Use `-X cancel` to leave copy mode cleanly before sending regular keystrokes again.
