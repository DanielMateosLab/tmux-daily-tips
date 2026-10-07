# Use send-keys with Format Strings to Create Self-Aware Commands

## Shortcut
```
send-keys -e 'command #{pane_index} #{window_name}'
```

## Explanation

The `-e` flag in `send-keys` expands tmux format strings (like `#{pane_index}`, `#{window_name}`, `#{session_name}`) before executing the command. This lets you build context-aware commands that "know" which pane, window, or session they're running in—useful for logging, tracing, or routing output to specific locations.

Unlike `-F` in other commands that just formats output, `-e` with `send-keys` embeds the expanded values directly into the command you're injecting.

## Example

Log which pane executed a command:

```
tmux send-keys -e 'echo "Running in pane #{pane_index} of window #{window_name}" >> ~/pane-log.txt' Enter
```

Create a debug log that includes session context:

```
tmux send-keys -e 'DEBUG_SESSION=#{session_name} ./script.sh' Enter
```

In a config bind-key:

```
bind-key M-l send-keys -e 'less +F ~/.log.#{session_name}.txt' Enter
```

This opens a log file specific to the current session, useful when monitoring multiple concurrent sessions.
