# Use `send-keys -X` to Trigger Copy-Mode Commands Without Entering Copy Mode

Copy mode has dozens of commands, and most of them can be invoked from a script or key binding using `send-keys -X`. This lets you drive a pane's scrollback directly: jump to the top, select a line, or copy text, without the user ever seeing copy mode.

## The Command

```
tmux send-keys -t <pane> -X <copy-mode-command>
```

The `-X` flag tells tmux to send the argument as a copy-mode command rather than as keystrokes. The pane must already be in copy mode for the command to take effect, so combine it with `copy-mode` first.

## Example

Scroll a pane to the top of its history, search for a word, and copy the match into a buffer, all from a single key binding:

```
bind-key S send-keys -t '{last}' -X copy-mode \; \
  send-keys -t '{last}' -X history-top \; \
  send-keys -t '{last}' -X search-backward "ERROR" \; \
  send-keys -t '{last}' -X copy-selection-and-cancel
```

Pressing `prefix + S` jumps the last-used pane to its first `ERROR` line and copies the match to the paste buffer.

## Practical Uses

- Bind a key to `history-top` to jump to the start of a long build log.
- Script a test harness that runs `copy-mode`, then `search-backward` for a failure marker, then `copy-selection-and-cancel` to capture the result.
- Combine with `capture-pane` when you need the output in a file rather than a buffer.

## Tips

- Run `tmux list-commands | grep copy-mode` to see the full set of copy-mode commands available in your version.
- Commands that take arguments, such as `search-backward`, accept them directly after the command name, as shown above.
- Use `-t` with the target pane explicitly in scripts so the command does not depend on which pane has focus.
