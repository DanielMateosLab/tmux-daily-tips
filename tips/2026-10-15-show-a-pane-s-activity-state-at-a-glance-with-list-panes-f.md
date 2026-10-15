# Show a pane's activity state at a glance with `list-panes -F`

The last tip in the series covers scrollback size. This one shows how to get a compact, scriptable snapshot of which panes are active, zoomed, or dead, using `list-panes` with a format string.

Run this in any pane:

```
tmux list-panes -s -F '#{session_name}:#{window_index}.#{pane_index} active=#{pane_active} zoomed=#{window_zoomed_flag} dead=#{pane_dead}'
```

The `-s` flag lists panes across the whole session instead of only the current window. Each line shows one pane, with three flags:

- `pane_active` is `1` for the pane that has focus in its window.
- `window_zoomed_flag` is `1` when the window is zoomed with `prefix z`.
- `pane_dead` is `1` for a pane whose process has exited and which is kept open by `remain-on-exit`.

Example output for a session with two windows:

```
work:0.0 active=0 zoomed=0 dead=0
work:0.1 active=1 zoomed=0 dead=0
work:1.0 active=1 zoomed=1 dead=0
work:1.1 active=0 zoomed=1 dead=1
```

Because the output is plain text, you can filter it. To find dead panes across all sessions, pipe the output through `grep`:

```
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_dead}' | grep ' 1$'
```

The `-a` flag lists panes on every session of the server. Swap the `grep` pattern to find any flag you need.
