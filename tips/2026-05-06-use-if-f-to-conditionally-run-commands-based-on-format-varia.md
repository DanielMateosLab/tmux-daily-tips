# Use `if -F` to Conditionally Run Commands Based on Format Variables

Tmux's `if-shell` command has a `-F` flag that evaluates tmux format variables instead of shelling out. This is faster and lets you branch on tmux's internal state — pane count, zoom status, window name, client size — without spawning a subprocess.

## The Command

```
if-shell -F "#{condition}" "command-if-true" "command-if-false"
```

With `-F`, the condition is evaluated as a tmux format string. Any non-zero, non-empty, non-"0" result is considered true.

## Why It's Useful

Plain `if-shell` runs `/bin/sh -c "..."` for every check, which adds latency — especially painful in status-bar refreshes or frequently-triggered key bindings. `-F` evaluates entirely inside tmux, so it's cheap enough to use in hooks and bindings that fire often.

## Example: Smart Zoom Toggle

Bind a key that zooms a pane only if the window has more than one pane (otherwise it's a no-op that just beeps):

```
bind-key z if-shell -F '#{!=:#{window_panes},1}' \
  'resize-pane -Z' \
  'display-message "Only one pane — nothing to zoom"'
```

## Example: Context-Aware Splitting

Split horizontally in wide terminals, vertically in narrow ones:

```
bind-key s if-shell -F '#{>:#{client_width},160}' \
  'split-window -h' \
  'split-window -v'
```

## Example: Skip Hooks in Specific Windows

Combine with hooks to silence activity alerts in a "logs" window:

```
set-hook -g alert-activity 'if-shell -F "#{!=:#{window_name},logs}" \
  "display-message \"Activity in #{window_name}\""'
```

## Tip

Test format expressions interactively with `display-message`:

```
tmux display-message -p '#{?#{==:#{window_panes},1},single,multi}'
```

This prints `single` or `multi` so you can verify your condition before wiring it into a binding.
