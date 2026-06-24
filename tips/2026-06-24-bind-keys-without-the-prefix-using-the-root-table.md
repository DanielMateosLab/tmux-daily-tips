# Bind Keys Without the Prefix Using the Root Table

## Command

```tmux
bind -n <key> <command>
```

The `-n` flag binds a key in the **root** key table, meaning it fires *without* pressing the prefix first. It's shorthand for `bind -T root`.

## Explanation

Normally every tmux key binding requires the prefix (e.g. `C-b`) as a gatekeeper. That's safe, but for actions you trigger dozens of times an hour — switching windows, splitting, navigating panes — the two-step dance gets tedious.

`bind -n` removes the prefix entirely for chosen keys. Pick combinations your shell and editors don't already use (Alt/Meta chords are ideal) to avoid collisions, then add them to `~/.tmux.conf`.

To remove a root binding later, use `unbind -n <key>`.

## Example

Add direct, prefix-free navigation to your config:

```tmux
# Switch windows with Alt+arrows — no prefix needed
bind -n M-Left  previous-window
bind -n M-Right next-window

# Move between panes with Alt+h/j/k/l
bind -n M-h select-pane -L
bind -n M-j select-pane -D
bind -n M-k select-pane -U
bind -n M-l select-pane -R

# Split the current pane with Alt+- and Alt+\
bind -n M-- split-window -v
bind -n 'M-\' split-window -h
```

Reload with `tmux source-file ~/.tmux.conf`, then press `Alt+Right` to jump to the next window instantly — no `C-b` required.

Inspect your root table any time with:

```tmux
tmux list-keys -T root
```

Tip: combine `-n` with `-r` (`bind -nr`) to make a no-prefix key repeatable within the `repeat-time` window — great for nudging pane sizes with bare arrow keys.
