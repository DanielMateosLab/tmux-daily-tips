# Show a tmux window's last activity time with `display-message`

Read the `window_activity` format variable to see when a window last produced output, as a Unix timestamp. Pass it to `date` to turn the number into a readable time.

```sh
tmux display-message -p -t build:2 '#{window_activity}'
```

Prints something like `1795680412`. Convert it with the shell:

```sh
date -r "$(tmux display-message -p -t build:2 '#{window_activity}')"
```

The `-p` flag prints the result to stdout instead of the status bar, so a script can capture it. The `-t build:2` target picks window 2 of the session named `build`. Omit `-t` to read the current window.

Use this in a script that decides whether a long-running job has gone quiet, for example by comparing the timestamp against `date +%s`.
