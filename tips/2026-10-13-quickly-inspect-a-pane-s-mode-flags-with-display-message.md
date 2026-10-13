# Quickly Inspect a Pane's Mode Flags with `display-message`

Need to know whether a pane is in copy mode, zoomed, synchronized, or has a dead process? Instead of hunting through the UI, query the pane's state directly with a format string.

## The Command

```
tmux display-message -p -t <pane> '#{pane_in_mode} #{window_zoomed_flag} #{synchronize-panes} #{pane_dead}'
```

Each `#{...}` expands to a value:

- `pane_in_mode` — `1` if the pane is in copy mode (or another mode), `0` otherwise
- `window_zoomed_flag` — `1` if the window is zoomed
- `synchronize-panes` — `1` if input is synchronized across panes in the window
- `pane_dead` — `1` if the pane's process has exited (only visible with `remain-on-exit`)

## Explanation

`display-message -p` prints the expanded format to stdout instead of the status bar, so the result lands in your terminal or your script. The `-t` flag targets a specific pane, which means you can inspect a pane you aren't focused on.

Because the output is plain text, this is useful in scripts that need to decide what to do next, such as skipping a pane that is already in copy mode before sending keys to it.

## Example

Check a pane before sending it a command:

```sh
state=$(tmux display-message -p -t work:1.2 '#{pane_in_mode}')
if [ "$state" = "0" ]; then
  tmux send-keys -t work:1.2 'make test' Enter
else
  echo "Pane work:1.2 is in a mode; skipping"
fi
```

Or make a quick one-off check from the prompt:

```sh
tmux display-message -p -t work:1.2 'in_mode=#{pane_in_mode} zoomed=#{window_zoomed_flag} sync=#{synchronize-panes}'
```

## Tip

Run `tmux display-message -p '#{pane_dead}'` inside a dead pane kept by `remain-on-exit` to confirm it has exited before respawning it.
