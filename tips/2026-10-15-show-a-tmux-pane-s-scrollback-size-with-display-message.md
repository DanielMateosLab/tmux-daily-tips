# Show a tmux pane's scrollback size with `display-message`

Use `display-message -p` with the `#{history_size}` and `#{history_limit}` format variables to see how many lines a pane has stored in its scrollback, and how many it can hold before old lines get dropped.

## Command

```sh
tmux display-message -p -t {pane} 'history: #{history_size} / #{history_limit} lines'
```

## Explanation

`history_size` reports the lines currently held in a pane's scrollback buffer. `history_limit` reports the maximum set by the `history-limit` option. When `history_size` reaches `history_limit`, tmux discards the oldest lines as new output arrives.

Checking these values tells you whether a long build or log tail is about to lose earlier output. It also shows whether a pane's limit differs from the global default, which happens when `history-limit` was changed after the pane was created. Pane creation fixes the limit at that moment, so a later change to the option does not resize existing panes.

The `-p` flag prints the result to stdout instead of the status line. `-t` targets a specific pane, and omitting it uses the current pane.

## Example

Check the active pane of another window in the same session:

```sh
tmux display-message -p -t work:2.1 'history: #{history_size} / #{history_limit} lines'
```

Output:

```
history: 4312 / 10000 lines
```

To check the value from a script, capture the number directly:

```sh
used=$(tmux display-message -p -t work:2.1 '#{history_size}')
```
