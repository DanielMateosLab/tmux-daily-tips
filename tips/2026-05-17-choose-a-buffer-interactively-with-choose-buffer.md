# Choose a Buffer Interactively with `choose-buffer`

**Command:** `prefix + =`

Tmux maintains a stack of paste buffers (every copy adds a new one), but most people only ever paste the most recent. The `choose-buffer` command opens an interactive picker showing every buffer with a preview of its contents, so you can paste an older selection without losing it.

## How it works

- Press `prefix + =` to open the buffer chooser.
- Use arrow keys (or `j`/`k`) to navigate; each line shows the buffer name, size, and first chunk of text.
- Press `Enter` to paste the highlighted buffer into the current pane.
- Press `d` to delete a buffer you no longer need, or `f` to filter by substring.
- Press `q` or `Escape` to dismiss without pasting.

This is the visual counterpart to `list-buffers` + `paste-buffer -b <name>`, but far faster when you have several captures in flight.

## Example workflow

You're debugging and have copied three different stack traces during a copy-mode session. Each `Enter` in copy mode pushed a new buffer onto the stack:

```
buffer0: "TypeError: cannot read property 'id'..."
buffer1: "psql: FATAL: database does not exist"
buffer2: "ECONNREFUSED 127.0.0.1:6379"
```

A normal `prefix + ]` only pastes the newest (`buffer2`). Instead:

1. Open your notes pane.
2. Press `prefix + =`.
3. Arrow down to `buffer0` (the TypeError), hit `Enter` — pasted.
4. Press `prefix + =` again, pick `buffer1`, hit `Enter` — pasted.

## Bonus: custom paste format

You can customize what each entry shows via the `-F` flag in a binding:

```tmux
bind = choose-buffer -F "#{buffer_name}: #{buffer_sample}" -Z
```

The `-Z` flag zooms the chooser to full screen, useful when previews are long.

Combined with `set -g buffer-limit 50` in `~/.tmux.conf`, you get a deep, searchable clipboard history that lives entirely inside tmux.
