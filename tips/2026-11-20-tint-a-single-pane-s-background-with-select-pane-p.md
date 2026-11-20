# Tint a single pane's background with select-pane -P

Run `select-pane -P` with a style string to change the background of one pane without touching the rest of the window. Use it to mark a shell that is connected to production, or any pane you want to recognise at a glance.

The `-P` flag takes the same style syntax as `window-style` (for example `bg=colour52`, `fg=white`, or `bg=default` to reset). The style applies only to the target pane, and it stays until you change or reset it. Choose a pane with the usual target rules, so `-t` accepts a pane ID such as `%3`.

To toggle the tint from a key, add two bindings to `~/.tmux.conf`:

```
bind-key T select-pane -P 'bg=colour52'
bind-key U select-pane -P 'bg=default'
```

Reload the config with `prefix` + `:` then `source-file ~/.tmux.conf`, or with the binding you already have for it. Press `prefix` + `T` to tint the current pane dark red and `prefix` + `U` to clear it. Pick different keys if `T` or `U` already do something in your setup; `tmux list-keys | grep -E ' (T|U) '` shows what is bound.

To tint a pane from a script without focusing it, pass the pane ID:

```
tmux select-pane -t %3 -P 'bg=colour22'
```

This paints pane `%3` dark green while you keep working in another pane. Run `tmux display-message -p '#{pane_id}'` inside the pane you want to target to find its ID.
