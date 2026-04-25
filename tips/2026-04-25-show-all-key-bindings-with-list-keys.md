# Show All Key Bindings with `list-keys`

**Shortcut:** `prefix + ?` (or `:list-keys` / `:list-keys -T <table>`)

Tmux ships with dozens of key bindings, and over time you'll accumulate even more from your own config. Instead of digging through the man page or your `.tmux.conf`, you can ask tmux directly what every key does — including bindings in non-default key tables like `copy-mode-vi` and `prefix`.

`prefix + ?` opens an interactive, scrollable list of every binding in the current key table. You can search it with `/` (forward) or `?` (backward), just like in copy-mode, and press `q` to exit. This is invaluable when you've forgotten a binding, want to discover features you didn't know existed, or are debugging a binding that isn't firing.

For non-interactive use — say, piping into `grep` or another tool — run `tmux list-keys` from the shell. Add `-T <table>` to inspect a specific table.

## Examples

Open the interactive list inside tmux:

```
prefix ?
# then type: /resize    → jumps to all resize-* bindings
# press: q              → close
```

Find every binding that calls `resize-pane` from the shell:

```
tmux list-keys | grep resize-pane
```

Inspect copy-mode-vi bindings (useful when customizing copy/paste):

```
tmux list-keys -T copy-mode-vi
```

See only the keys you've added or overridden, sorted:

```
tmux list-keys -T prefix | sort
```

Pro tip: pair this with `prefix + :` and type `list-keys -1N <key>` to get a one-line, human-readable note for a single key — e.g. `list-keys -1N C-a` shows exactly what `prefix + Ctrl-a` is bound to without dumping the whole table.
