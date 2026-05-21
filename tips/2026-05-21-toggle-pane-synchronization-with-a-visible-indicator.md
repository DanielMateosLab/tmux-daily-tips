# Toggle Pane Synchronization with a Visible Indicator

**Command:** `bind-key e set-window-option synchronize-panes\; display-message "synchronize-panes is now #{?pane_synchronized,ON,OFF}"`

While `setw synchronize-panes` is well-known, the friction is that you can never tell whether it's currently active — which is dangerous when the next keystroke might run `rm -rf` in every pane at once. Bind a single key that toggles the option *and* echoes the new state to the status line, so you always have feedback.

The trick is the `#{?pane_synchronized,ON,OFF}` format conditional: tmux exposes `pane_synchronized` as a format variable, so you can render different text depending on whether sync is currently on or off after the toggle.

## Example

Add to `~/.tmux.config`:

```tmux
bind-key e setw synchronize-panes \; display-message "sync: #{?pane_synchronized,ON ⚠️,OFF}"
```

Reload with `prefix + :` then `source-file ~/.tmux.conf`.

Now `prefix + e` toggles broadcast typing and flashes a status message like:

```
sync: ON ⚠️
```

or

```
sync: OFF
```

For an even more permanent indicator, append the same conditional to your status-right so synced windows are visually marked at all times:

```tmux
set -g status-right "#{?pane_synchronized,#[bg=red]SYNC#[default] ,}%H:%M"
```

When sync is active, a red `SYNC` badge appears in the status bar — no more accidental multi-pane `sudo` mishaps.
