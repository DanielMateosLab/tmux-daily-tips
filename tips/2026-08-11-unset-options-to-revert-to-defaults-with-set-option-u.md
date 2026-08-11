# Unset Options to Revert to Defaults with set-option -u

## The Shortcut

```tmux
set-option -u option-name
set-option -uw option-name  # window-local
set-option -us option-name  # session-local
```

## What It Does

Use the `-u` flag to unset (remove) a custom option value and revert to tmux's built-in defaults. This is cleaner than setting an empty value and useful when you want to disable a customization without restarting tmux.

## Example

You've customized your status bar style globally:

```tmux
set-option -g status-style bg=blue
```

Later, you decide to revert. Instead of guessing the default, use `-u`:

```tmux
set-option -u -g status-style
```

The option immediately reverts to tmux's default. Verify with:

```tmux
show-options -g status-style
```

This is especially powerful for session or window-local overrides—unset them without touching your global config:

```tmux
set-option -us status-style  # remove session-local override
set-option -uw status-style  # remove window-local override
```

### Why It Matters

When layering options across global, session, and window scopes, `-u` gives you precise control. No more guessing defaults or restarting tmux to reset a bad config.
