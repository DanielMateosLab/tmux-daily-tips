# Clear the Scrollback History Without Killing the Pane

Sometimes a pane's scrollback gets cluttered with old build output, stack traces, or sensitive data you'd rather not leave lying around. Instead of killing and respawning the pane, tmux lets you wipe the scrollback buffer in place.

## The command

```
tmux clear-history
```

Or from inside tmux, via the prefix command prompt:

```
<prefix> : clear-history
```

You can also target another pane without switching to it:

```
tmux clear-history -t mysession:1.2
```

## What it does

`clear-history` removes all lines stored in the pane's scrollback buffer (the lines that scroll off the visible region). It does **not** clear the visible screen — that's what `clear` or `Ctrl-L` is for. The two are complementary: `clear` empties what you see, `clear-history` empties what you've scrolled past.

This is useful when:

- A long-running process dumped megabytes of logs and tmux is hogging memory
- You ran a command with secrets and want them gone from scrollback before detaching
- You want a clean slate before starting a copy-mode search

## Bind it to a key

Add this to `~/.tmux.conf` to wipe both the visible screen and the scrollback with one keystroke:

```tmux
bind -n C-k send-keys -R \; clear-history
```

Now `Ctrl-k` (no prefix) sends a terminal reset (`-R`) to the shell and clears the history buffer in one motion. The visible prompt redraws cleanly and copy-mode starts fresh.

## Verify it worked

Check the current scrollback size with:

```
tmux display -p '#{history_size} / #{history_limit}'
```

Right after `clear-history`, `history_size` drops to `0`.

## Bonus: clear every pane at once

```
tmux list-panes -a -F '#{pane_id}' | xargs -I {} tmux clear-history -t {}
```

Handy before sharing a session or recording a demo.
