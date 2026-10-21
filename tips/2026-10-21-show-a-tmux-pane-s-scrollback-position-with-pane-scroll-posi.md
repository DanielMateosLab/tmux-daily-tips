# Show a tmux Pane's Scrollback Position with `pane_scroll_position`

Tmux tracks how far you've scrolled back in a pane's history. The `pane_scroll_position` format variable exposes that offset, so you can check it from a script, a status line, or `display-message` without entering copy mode.

## Command

```
tmux display-message -p '#{pane_scroll_position}'
```

The value is the number of lines above the bottom of the pane. `0` means the pane is showing live output. Any other number means you are scrolled back into history.

## Explanation

- `#{pane_scroll_position}` returns the current scroll offset of the target pane. It is only non-zero while the pane is in copy mode (or scrolled via the mouse, which enters copy mode).
- Use `-p` to print the result to stdout instead of the status bar.
- Add `-t` to target a specific pane, for example `-t %3`.

## Example

Put this in your tmux config to show a warning in the status bar when a pane is scrolled back:

```
set -g status-right '#{?#{e|>:#{pane_scroll_position},0},#[fg=yellow]SCROLLED #{pane_scroll_position}#[default] ,}%H:%M'
```

When you scroll up in a pane, the status bar shows `SCROLLED 42` (or whatever the line offset is). Scroll back to the bottom and the label disappears.

To check from a script before sending keys:

```
if [ "$(tmux display-message -p -t %3 '#{pane_scroll_position}')" -gt 0 ]; then
  tmux send-keys -t %3 q
fi
```

This exits copy mode in the target pane only when it is scrolled back.
