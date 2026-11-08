# Clear the scrollback with a single keypress and keep the prompt usable

Want to wipe a pane's history with one keystroke instead of typing a command? Bind a key that runs `clear-history` on the current pane. This is useful when you want a clean slate before a long test run without losing the running shell.

## The command

```
tmux clear-history
```

By default this clears the scrollback for the active pane only. The visible contents stay on screen, so your current prompt and output remain untouched.

## Bind it to a key

Add this to `~/.tmux.conf`:

```
bind-key L clear-history
```

Reload the config with `tmux source-file ~/.tmux.conf`, then press `prefix` followed by `L` whenever you want to drop the history.

## Why it helps

- It doesn't interrupt the running process or the shell.
- It doesn't clear the visible screen, so you keep your context.
- Pressing `prefix L` is faster than entering copy mode or scrolling to find old output.

## Example

Run a noisy build:

```
make build 2>&1 | tail -n 5
```

Scroll history now holds hundreds of lines of compiler output. Press `prefix L`, and the history is gone. Run `prefix [` and scroll up: only the visible screen remains.

## Tip

If you also want the visible screen cleared, use `clear-history` together with the shell's own `clear` command, or send `C-l` with `send-keys`.
