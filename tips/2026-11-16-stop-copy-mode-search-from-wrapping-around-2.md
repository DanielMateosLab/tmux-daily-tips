# Stop copy-mode search from wrapping around

When you search in copy mode, tmux wraps to the top of the history once it hits the end. To stop that, set `wrap-search` to off.

```
tmux set -g wrap-search off
```

Once it's off, `n` and `N` stop at the first and last match instead of cycling. This helps when you're hunting through a long log and need to know you've reached the oldest or newest hit.

To check the current value:

```
tmux show -g wrap-search
```

To make the change survive a restart, put the line in `~/.tmux.conf` and reload with `tmux source-file ~/.tmux.conf`.
