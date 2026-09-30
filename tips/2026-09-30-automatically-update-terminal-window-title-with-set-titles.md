# Automatically Update Terminal Window Title with set-titles

Automatically synchronize your terminal emulator's title bar with the current tmux session and window using `set-titles`.

## Command

```
set-option -g set-titles on
set-option -g set-titles-string "#{session_name}:#{window_name}"
```

## Explanation

When `set-titles` is enabled, tmux updates your terminal's title bar to reflect your current session and window context. This is useful when running tmux inside a terminal tab, allowing you to see at a glance which session and window you're viewing without switching focus.

The title updates automatically when you switch windows, rename windows, or change sessions—no manual intervention needed.

## Example

Add to `.tmux.conf`:

```
set-option -g set-titles on
set-option -g set-titles-string "tmux: #{session_name}:#{window_index}-#{window_name}"
```

Now switching windows automatically updates your terminal title: `tmux: dev:1-editor` → `tmux: dev:2-logs`. You can customize the format string with any tmux variable: `#{session_name}`, `#{window_index}`, `#{window_name}`, `#{pane_title}`, etc.

Combine this with `rename-window` to keep titles descriptive and instantly visible across your workflow.
