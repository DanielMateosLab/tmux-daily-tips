# Use unbind-key to Disable or Replace Keybindings

**Command:** `unbind-key [-T <table>] <key>`

Remove a keybinding entirely with `unbind-key`, or use it before rebinding to avoid conflicts. Useful for disabling tmux defaults you don't use, or resetting keybindings between config reloads.

## Examples

Disable the default paste keybinding:

```
unbind-key ]
```

Remove a keybinding from a specific key table:

```
unbind-key -T copy-mode-vi y
```

Replace a keybinding by unbinding then rebinding:

```
unbind-key C-Space
bind-key C-Space select-pane -m
```

Disable all window navigation to force using select-window:

```
unbind-key n
unbind-key p
```

Unbind from root table (unprefix'd keys):

```
unbind-key -T root MouseDown1Pane
```

This is essential when migrating between keybinding schemes, preventing accidental triggers, or reclaiming keys for custom commands without worrying about conflicting defaults.
