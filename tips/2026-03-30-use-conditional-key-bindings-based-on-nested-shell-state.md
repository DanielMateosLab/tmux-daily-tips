

# Use Conditional Key Bindings Based on Nested Shell State

## The Shortcut

```
bind-key -n M-Up if-shell "[ '#{pane_current_command}' = 'ssh' ]" "send-keys M-Up" "select-pane -U"
```

## What It Does

`if-shell` inside a key binding lets tmux run different actions depending on a condition — like what command the active pane is running. This is invaluable when you need the same key to behave differently depending on context (e.g., navigating tmux panes normally, but passing keys through when inside `ssh`, `vim`, or `fzf`).

## Why It Matters

A common frustration: you set up convenient pane-navigation bindings with `Alt+Arrow`, but they conflict with keybindings inside programs running in your panes. Conditional bindings solve this cleanly — tmux checks the context and decides whether to handle the key itself or forward it to the inner program.

## Concrete Example

Add these to your `~/.tmux.conf` to get smart pane navigation that defers to Vim when it's the active program:

```bash
# Smart pane switching: Alt+Arrow navigates panes unless Vim is running
is_vim="ps -o state=,comm= -t '#{pane_tty}' | grep -qE 'S\\+\\s*(vim|nvim)'"

bind-key -n M-Left  if-shell "$is_vim" "send-keys M-Left"  "select-pane -L"
bind-key -n M-Right if-shell "$is_vim" "send-keys M-Right" "select-pane -R"
bind-key -n M-Up    if-shell "$is_vim" "send-keys M-Up"    "select-pane -U"
bind-key -n M-Down  if-shell "$is_vim" "send-keys M-Down"  "select-pane -D"
```

Now `Alt+Arrow` moves between tmux panes everywhere **except** when the cursor is in Vim, where the keys pass through untouched.

## Other Useful Conditions

```bash
# Forward Escape quickly unless in copy-mode (avoids delay when exiting fzf)
bind-key -n Escape if-shell "tmux display -p '#{pane_in_mode}'" "send-keys Escape" "copy-mode"

# Use a different prefix behavior when pane is zoomed
bind-key z if-shell "[ '#{window_zoomed_flag}' = '1' ]" "resize-pane -Z" "resize-pane -Z \; display 'Zoomed!'"
```

## Tip

The shell command in `if-shell` runs synchronously by default. For key bindings that must feel instant, keep the shell test lightweight (a single `grep` or variable check). You can also use tmux format conditionals with `#{?...}` for zero-overhead checks on tmux's own variables.
