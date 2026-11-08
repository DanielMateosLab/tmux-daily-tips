# Clear the pane and scrollback in one keypress with a custom binding

Most people clear a pane with `clear` or `Ctrl-l`, but neither removes the history. You can use `clear-history` together with a shell clear so the pane looks empty and the scrollback is wiped too, all with one prefix keybinding.

## The shortcut

tmux has no built-in "clear everything" key, so you add one to your config:

```
bind-key C-k send-keys C-l \; clear-history
```

- `send-keys C-l` tells the shell to redraw and clear the visible screen.
- `\;` chains a second tmux command in the same binding.
- `clear-history` discards the scrollback for the current pane.

After reloading (`tmux source-file ~/.tmux.conf`), press `prefix` then `Ctrl-k`.

## Why it helps

Plain `Ctrl-l` only scrolls the visible text up out of view. The lines are still in history, so `prefix [` and scrolling will reveal them. Binding both actions gives you a clean slate that is really clean, which is useful before running a command whose output you want to read in isolation or before sharing a screen.

## Example

```
# ~/.tmux.conf
bind-key C-k send-keys C-l \; clear-history
```

Then:

1. Run a noisy command, such as `ls -R /usr`.
2. Press `prefix` `Ctrl-k`.
3. Scroll up with `prefix [`. The earlier output is gone.
