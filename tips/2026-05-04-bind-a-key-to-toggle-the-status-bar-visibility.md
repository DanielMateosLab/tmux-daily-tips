# Bind a Key to Toggle the Status Bar Visibility

**Command:** `set-option status` (toggle with a custom binding)

The tmux status bar is useful, but sometimes you need every last row of terminal real estate — for tailing logs, reading code, or taking a screenshot. Instead of permanently disabling it, bind a key to toggle it on and off instantly with a single keystroke.

## How it works

The `status` option accepts `on` or `off`. Combine it with `if-shell` (or the simpler `\;` chained syntax) inside a key binding so one shortcut flips between the two states.

## Example

Add this to your `~/.tmux.conf`:

```tmux
bind-key b set-option status
```

Because `set-option status` without an argument toggles the value, pressing `prefix + b` now hides the status bar if it's showing, or shows it if it's hidden.

Want a fancier version that also reports the new state?

```tmux
bind-key b set-option status \;\
          display-message "Status: #{?status,on,off}"
```

## Why it's useful

- **Reclaim a row** when reading long output or comparing files in split panes.
- **Distraction-free mode** for screen recordings or pair-programming demos.
- **No reload needed** — the change is immediate and per-session, so other sessions keep their status bars intact.

## Bonus: toggle just the position

If you only want to flip the bar between top and bottom rather than hiding it entirely:

```tmux
bind-key B set-option status-position "#{?#{==:#{status-position},top},bottom,top}"
```

A quick `prefix + B` and the status bar jumps to the other edge of the screen — handy when a popup or floating window obscures it.
