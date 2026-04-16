

# Use `source-file` to Reload Config Without Restarting

When tweaking your `~/.tmux.conf`, you don't need to kill your session and start over. The `source-file` command re-reads your configuration file in place, applying changes immediately.

## The Command

```
tmux source-file ~/.tmux.conf
```

Or from inside tmux, hit your prefix and use the command prompt:

```
Prefix + : source-file ~/.tmux.conf
```

## Bind It for One-Keystroke Reloads

Add this to your `~/.tmux.conf` so you can reload with `Prefix + r`:

```tmux
bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
```

The `display-message` at the end gives you visual confirmation in the status bar that the reload actually happened.

## What Gets Applied

- New or changed key bindings
- Status bar style and format changes
- Option changes (`set` and `setw` directives)
- New hooks and environment variables

## What Doesn't Change

Existing windows and panes keep their state. If you *removed* a key binding from the file, the old binding remains active in the running server because `source-file` is additive — it runs each line as a command but doesn't reset unmentioned settings.

To truly "reset" a binding, explicitly unbind it:

```tmux
unbind C-z
```

## Sourcing Multiple Files

You can organize your config into modular files and source them all:

```tmux
# In ~/.tmux.conf
source-file ~/.tmux/keybindings.conf
source-file ~/.tmux/theme.conf
source-file -q ~/.tmux/local.conf   # -q suppresses errors if file is missing
```

The `-q` (quiet) flag is useful for machine-specific overrides that may not exist on every host — tmux won't complain if the file is absent.
