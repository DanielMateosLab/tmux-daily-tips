# Show a tmux window's last-activity time with `display-message`

Format variable `#{window_activity}` returns the Unix timestamp of the last output in a window. Pair it with `date -r` in a shell or `%`-expansion in `strftime` to see how long a background window has been quiet.

## Command

```
tmux display-message -p '#{window_activity}'
```

Run it from a pane, or target a specific window with `-t`:

```
tmux display-message -p -t mysession:2 '#{window_activity}'
```

## Explanation

`window_activity` holds the epoch seconds of the most recent output in that window. The `-p` flag prints the expanded result to stdout instead of the status line, so the value lands in your shell.

Convert it to a readable time with `date`:

```
tmux display-message -p -t mysession:2 '#{t:window_activity}'
```

The `t:` modifier formats the timestamp as a human-readable date using tmux's own formatting, so you do not need to pipe through `date`. To see how long ago a window last produced output, subtract the value from `#{t:...}` of the current time in a script:

```
now=$(date +%s)
last=$(tmux display-message -p -t mysession:2 '#{window_activity}')
echo "idle for $((now - last))s"
```

This works for any window, including ones you are not looking at, so a build or long job in a background window reports its quiet period without switching focus.

## Example

Check whether a background test runner in window `tests` has gone quiet for more than a minute:

```
now=$(date +%s)
last=$(tmux display-message -p -t work:tests '#{window_activity}')
if (( now - last > 60 )); then
  tmux display-message "tests idle for $((now - last))s"
fi
```

The check reads the timestamp only, so it adds no load to the pane being watched.
