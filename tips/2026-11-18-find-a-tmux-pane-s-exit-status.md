# Find a tmux pane's exit status

Use `display-message -p '#{pane_dead_status}'` to read the exit code of a finished command in a pane kept alive by `remain-on-exit`. Run it from any pane to check whether a background job succeeded without scrolling back through its output.

## Command

```
tmux display-message -p -t <target> '#{pane_dead_status}'
```

## Explanation

When `remain-on-exit` keeps a pane after its process ends, tmux stores the exit code in the `pane_dead_status` format variable. The variable is empty while the process still runs, so an empty result means the job has not finished. `-p` prints the value to stdout instead of the status bar, which makes it usable in scripts.

## Example

Run a build in a pane, then check its result from another pane:

```
tmux set -w remain-on-exit on
tmux send-keys -t build:0.1 'make test' Enter
```

Once `make test` finishes, read its exit code:

```
tmux display-message -p -t build:0.1 '#{pane_dead_status}'
0
```

A script can branch on the value:

```
if [ "$(tmux display-message -p -t build:0.1 '#{pane_dead_status}')" = "0" ]; then
  echo "tests passed"
fi
```
