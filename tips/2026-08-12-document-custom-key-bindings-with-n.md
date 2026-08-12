# Document Custom Key Bindings with -N

## The shortcut

```
bind-key -N "Description" <keys> <command>
```

## Why it's useful

Custom key bindings are easy to forget. The `-N` flag adds help text visible in `list-keys`, creating self-documenting config without extra effort.

## Example

In `.tmux.conf`:

```tmux
bind-key -N "Create new project session" C-n new-session -d -s proj
bind-key -N "Toggle status bar" C-b set-option status
bind-key -N "Jump to last window" C-l select-window -l
bind-key -N "Clear scrollback history" C-k clear-history
```

Run `tmux list-keys` to see all bindings with descriptions:

```
C-n                    Create new project session
C-b                    Toggle status bar
C-l                    Jump to last window
C-k                    Clear scrollback history
```

View descriptions for specific key tables:

```bash
tmux list-keys -T root         # Prefix-less bindings
tmux list-keys -T copy-mode-vi # Copy mode bindings (if using vi keys)
```

This is invaluable when you have many custom keybindings and need a quick reference without diving into your config file.
