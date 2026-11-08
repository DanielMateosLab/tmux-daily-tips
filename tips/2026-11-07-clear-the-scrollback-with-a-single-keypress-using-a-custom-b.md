# Clear the scrollback with a single keypress using a custom binding

Tmux's `clear-history` command wipes a pane's scrollback buffer, but you normally have to type it in the command prompt. Binding it to a key makes clearing a noisy pane a one-keypress job.

## The command

```
tmux bind-key -n C-k clear-history \; send-keys C-l
```

- `bind-key -n` binds in the root table, so no prefix is needed.
- `clear-history` empties the scrollback for the active pane.
- `send-keys C-l` redraws the prompt so the visible screen is clean too.

The `\;` separator chains the two commands into one binding.

## Making it permanent

Add the line to `~/.tmux.conf`, then reload:

```
bind-key -n C-k clear-history \; send-keys C-l
```

```
tmux source-file ~/.tmux.conf
```

## Example

You run a verbose build that floods the pane with thousands of lines. Instead of typing `:clear-history` and then `Ctrl-l`, press `Ctrl-k`. The scrollback is gone, the prompt is redrawn at the top, and `Ctrl-k` scrolls nothing back, so you can search cleanly from a fresh start.

> Tip: `C-k` is also readline's "kill to end of line," so the binding shadows it in the shell. Pick another key such as `C-M-k` if you use that shortcut often.
