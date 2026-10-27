# Show a tmux window's pane count with a `window_panes` format in `status-left`

Pick a tmux format variable and render it on the left side of the status bar so you can tell at a glance how many panes each session has open.

The status bar's left side is controlled by the `status-left` option. You can mix literal text with format variables such as `#{session_name}`, `#{window_index}`, and `#{window_panes}`. The last one is the total number of panes in the current window.

## Example

Add this to `~/.tmux.conf`:

```tmux
set -g status-left "[#{session_name}] #{window_index}:#{window_name} (#{window_panes}p) "
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

The left side of the status bar now reads something like:

```
[work] 2:editor (3p)
```

`#{window_panes}` updates the moment you split or kill a pane, so the count stays accurate without a manual refresh.

To check the value before committing it to the config, run:

```tmux
tmux display-message -p '#{window_panes}'
```

This prints the pane count for the current window to the command line.

Set `status-left-length` if the text gets truncated, since tmux caps the left side at 10 characters by default:

```tmux
set -g status-left-length 40
```
