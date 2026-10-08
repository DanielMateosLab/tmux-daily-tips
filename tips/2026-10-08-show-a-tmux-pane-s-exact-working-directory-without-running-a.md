# Show a tmux pane's exact working directory without running a command

Need the path of another pane, or of a pane you're about to split from? Ask tmux for it with `display-message -p` and a format string. No `pwd` in the pane, no `cd` side effects.

## Command

```
tmux display-message -p -t <target> '#{pane_current_path}'
```

`-p` prints the result to stdout instead of the status bar. `-t` picks the pane. `#{pane_current_path}` is the directory the pane's shell is currently in, as tmux tracks it.

## Why it's useful

Running `pwd` in a pane means typing into that pane, and that breaks when the pane is busy (a running REPL, `vim`, `ssh`). The format variable reads tmux's own state, so it works regardless of what the pane is running.

## Example

From a script or another pane, copy the path of the pane `1.2` (window 1, pane 2) into a variable:

```
dir=$(tmux display-message -p -t 1.2 '#{pane_current_path}')
tmux split-window -c "$dir"
```

The new split opens in the same directory as pane `1.2`, without touching that pane.

To check the path of whichever pane you're in, drop `-t`:

```
tmux display-message -p '#{pane_current_path}'
```
