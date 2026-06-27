# Use vi-Style Keys in Copy Mode and Command Prompt

If you live in Vim, tmux's default emacs-style copy mode bindings feel alien. The `mode-keys` and `status-keys` options switch tmux over to vi-style navigation, so `h/j/k/l`, `/` search, `v` selection, and `gg`/`G` jumps all work the way your fingers expect.

## The setting

Add this to `~/.tmux.conf`:

```tmux
# vi keys when navigating scrollback / copy mode
setw -g mode-keys vi

# vi keys at the command prompt (prefix : and command-prompt)
set -g status-keys vi
```

Reload with `prefix + :` then `source-file ~/.tmux.conf` (or `tmux source ~/.tmux.conf`).

## What you get in copy mode

Enter copy mode with `prefix + [`, then:

- `h j k l` — move left/down/up/right
- `w` / `b` — jump word forward/back
- `0` / `$` — start / end of line
- `gg` / `G` — top / bottom of buffer
- `/` and `?` — search forward / backward, `n` / `N` to repeat
- `v` — start selection, `V` line selection, `Ctrl-v` block selection
- `y` — yank selection and exit

## Make yank match Vim more closely

The defaults bind `Enter` to copy. Rebind so `v` begins and `y` confirms, just like a real Vim yank:

```tmux
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-selection-and-cancel
bind -T copy-mode-vi C-v send -X rectangle-toggle
```

## Example

```
prefix + [        # enter copy mode
?error            # search backward for "error"
n                 # next match up
v                 # start selecting
$                 # extend to end of line
y                 # copy and leave copy mode
prefix + ]        # paste it elsewhere
```

Check what's active any time with `prefix + : show -g mode-keys`. One line of config and scrollback navigation finally feels like home.
