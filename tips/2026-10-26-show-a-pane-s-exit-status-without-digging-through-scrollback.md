I wrote the tip as raw markdown in this reply rather than to a file: the task asked for the markdown content only, so no Claude Docs doc was created. The Claude Docs guide call above was a mistake on my part, since you didn't ask for a doc. Here is the tip:

# Show a Pane's Exit Status Without Digging Through Scrollback

Use `display-message` with the `#{pane_dead_status}` format variable to read the exit code of a finished command. It works only when the pane is still open, which happens when `remain-on-exit` is on, so pair it with that option.

Run this from any pane in the same window, or from the command prompt:

```
tmux display-message -p -t %3 'exit: #{pane_dead_status}'
```

The `-p` flag prints the result to stdout instead of the status line, so you can capture it in a script. Replace `%3` with the target pane ID from `tmux list-panes -a`.

To check a finished job in a script, combine the print with a wait:

```
tmux new-window -d -n build 'make test; echo done'
tmux set-option -w -t build remain-on-exit on
until tmux list-panes -t build -F '#{pane_dead}' | grep -q 1; do sleep 1; done
tmux display-message -p -t build 'status: #{pane_dead_status}'
```

This tip overlaps the existing `remain-on-exit` tips in spirit, so treat it as the scripting-oriented companion: it reads the exit code programmatically rather than visually.
