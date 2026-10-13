# Clear a Pane's Prompt Line Without Losing History: `send-keys C-u`

Most shells let you wipe the current input line with `Ctrl-u`, but tmux can send that keystroke to any pane without switching focus. This is useful when a script or a background pane has half-typed input that you want to discard before running something new.

## The Command

```sh
tmux send-keys -t <target> C-u
```

`C-u` is the readline "kill from cursor to start of line" binding. Sending it to a pane clears whatever is pending on the prompt, and the shell's history stays intact because nothing is executed.

## Why It's Useful

- A pane is waiting at a prompt with leftover text from an earlier, abandoned command.
- You are about to send a new command with `send-keys`, and you want to guarantee the line starts empty.
- You want to clean up a pane you are monitoring without stealing focus from your current work.

Unlike `send-keys C-c`, which interrupts the running process, `C-u` only edits the input buffer, so it is safe to use while a long-running job is not at a prompt.

## Example

Suppose pane `2` in the current window has a half-typed command left from earlier:

```sh
# Pane 2 shows: $ git commti -m "wip"   <- typo, never submitted
tmux send-keys -t 2 C-u
tmux send-keys -t 2 'git commit -m "fix: resolve parser edge case"' Enter
```

The first command empties the stale line. The second types the corrected command and submits it, all without changing the active pane.

## Tip

Combine it with `C-a` or `C-e` if you want to clear only part of the line. For a full reset of the input line plus scrollback, see `send-keys -R` in the tips on clearing pane history.
