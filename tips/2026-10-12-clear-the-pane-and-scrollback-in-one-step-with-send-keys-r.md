# Clear the Pane and Scrollback in One Step with `send-keys -R`

Tmux has no single built-in "clear everything" key, but you can combine `send-keys` with the `-R` flag to reset the pane's terminal state and redraw it, which clears stray escape sequences left behind by full-screen programs (like `less`, `htop`, or a crashed `vim`) that a plain `clear` may not fix.

## The command

```
tmux send-keys -R
```

`-R` tells tmux to reset the target pane's terminal emulation state (equivalent to running `reset` in the shell) before sending any keys. Combine it with `-t` to target a specific pane.

## Why it helps

A plain `clear` only scrolls the visible screen and emits a clear-screen sequence. If a program left the terminal in a bad state (wrong character set, stuck in alternate screen mode, mouse reporting still on), `clear` won't undo that. `send-keys -R` resets those modes so the pane behaves normally again, without killing the shell.

## Bind it to a key

Add this to `~/.tmux.conf`:

```
bind R send-keys -R \; send-keys C-l
```

- `send-keys -R` resets the pane's terminal state.
- `send-keys C-l` then redraws the prompt cleanly.

Reload with `tmux source-file ~/.tmux.conf`, then press `prefix` + `R` whenever a pane looks garbled.

## Example

Suppose you `cat` a binary file by accident and the terminal fills with unreadable characters and stops echoing your input:

```
$ cat /bin/ls
<garbled output>
```

Press `prefix` + `R`. The pane resets, the stray modes clear, and the prompt returns. You can then continue working in the same shell session without opening a new pane.
