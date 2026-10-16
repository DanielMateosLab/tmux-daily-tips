# Mirror Your Last Few Panes' Output with `capture-pane -S` Ranges

Need to grab a specific slice of scrollback without dumping the whole history? `capture-pane` accepts `-S` (start line) and `-E` (end line) so you can pull exactly the range you want.

## The Command

```sh
tmux capture-pane -p -S <start> -E <end>
```

- `-p` prints to stdout instead of a paste buffer.
- `-S` and `-E` are line offsets. Negative numbers count back from the visible area (`-1` is the last line of the visible screen's history above it, `-0` is the top of the visible pane). Use `-` alone to mean "start of history" and `-E -` for "end of visible area".

## Why It's Useful

Most capture tricks grab everything or search for a pattern. When you know roughly where the output you care about sits (say, the 40 lines before the last prompt), a range keeps the result small and predictable, which matters when piping into `less`, `grep`, or an LLM prompt.

## Example

Grab the 60 lines of scrollback just before the visible screen:

```sh
tmux capture-pane -p -S -60 -E -1 > /tmp/recent-output.txt
```

Show only the last 25 lines of history in a pager:

```sh
tmux capture-pane -p -S -25 -E -1 | less
```

## Tip

Combine with `-J` to join wrapped lines, so a long error message stays on one logical line when you copy it out:

```sh
tmux capture-pane -p -J -S -40 -E -1 | pbcopy
```
