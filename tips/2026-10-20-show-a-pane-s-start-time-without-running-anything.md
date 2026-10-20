# Show a Pane's Start Time Without Running Anything

Need to know when a pane's process was launched? tmux tracks this, and you can read it with `display-message` and the `#{pane_start_time}` format variable. It is a Unix timestamp, so you can pipe it through `date` for a readable value.

## Command

```
tmux display-message -p '#{pane_start_time}'
```

Run it inside the pane you want to inspect, or target another pane with `-t`:

```
tmux display-message -p -t work:1.2 '#{pane_start_time}'
```

## Explanation

- `-p` prints the result to stdout instead of the status bar.
- `#{pane_start_time}` expands to the Unix epoch seconds when the pane was created.
- Because the value is a raw timestamp, convert it with `date` when you need a human-readable time.

This is useful for checking how long a long-running process has been alive, or for confirming whether a pane was recreated after a crash.

## Example

Convert the start time to a readable local timestamp:

```
tmux display-message -p '#{pane_start_time}' | xargs -I{} date -r {}
```

Compute how long the pane has been running, in seconds:

```
echo $(( $(date +%s) - $(tmux display-message -p '#{pane_start_time}') ))
```

Bind a key that shows the pane's age in the status bar:

```
bind-key A display-message "Pane age: $(( $(date +%s) - #{pane_start_time} ))s"
```

Note that the last example relies on tmux expanding `#{pane_start_time}` before the shell arithmetic runs, which works because the format is substituted in the `display-message` argument.
