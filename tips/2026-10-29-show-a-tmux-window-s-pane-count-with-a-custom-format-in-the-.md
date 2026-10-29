# Show a tmux Window's Pane Count With a Custom Format in the Status Bar

tmux exposes a `#{window_panes}` format variable that holds how many panes a window contains. Combined with `#{?...}` conditionals, you can display it only when a window has more than one pane, keeping single-pane windows clean.

## The Idea

Rather than showing a count on every window, use a format conditional so the indicator appears only when there is something to tell apart:

```
#{?#{>:#{window_panes},1},[#{window_panes}p],}
```

- `#{>:a,b}` returns `1` when `a > b`.
- `#{?cond,yes,no}` picks the branch based on the condition.
- An empty `no` branch means single-pane windows show nothing.

## Configuration

Add this to `~/.tmux.conf` and reload:

```tmux
set -g window-status-format '#I:#W #{?#{>:#{window_panes},1},[#{window_panes}p],}'
set -g window-status-current-format '#I:#W #{?#{>:#{window_panes},1},[#{window_panes}p],}'
```

Reload the config:

```
tmux source-file ~/.tmux.conf
```

## Example

A window named `build` with three panes shows:

```
1:shell  2:build[3p]*  3:logs
```

Window 1 and 3 have a single pane, so nothing extra appears. Window 2 shows `[3p]` because it holds three panes.

## Verify the Value

Check a window's pane count directly:

```
tmux display-message -p -t build '#{window_panes}'
```

Use `display-message -p` with a format string to test expressions before putting them in your config.
