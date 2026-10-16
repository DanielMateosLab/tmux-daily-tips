# Show a pane's scrollback size with display-message

The `#{history_size}` format variable reports how many lines of scrollback a pane holds, and `#{history_limit}` reports the cap it can grow to. Together they tell you whether a long-running pane is close to dropping old output.

## Command

```
tmux display-message -p '#{history_size}/#{history_limit}'
```

Run it from any shell inside the pane, or target another pane with `-t`.

## Explanation

`history_size` counts the lines currently stored in the pane's scrollback buffer. `history_limit` is the maximum set by the `history-limit` option at the time the pane was created. Once `history_size` reaches `history_limit`, tmux discards the oldest line for every new one it adds.

The `-p` flag prints the expanded format to stdout instead of the status line, so the value lands in your shell where you can read or pipe it.

## Example

Check a build pane before starting a long job:

```
$ tmux display-message -p -t build:0.1 '#{history_size}/#{history_limit}'
1843/2000
```

The pane has 157 lines of room left, so a verbose build could push its start-of-run output out of view. Clear the history with `clear-history` or raise `history-limit` in your config before the job starts.
