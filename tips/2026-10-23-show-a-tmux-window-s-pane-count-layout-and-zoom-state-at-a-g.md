# Show a tmux window's pane count, layout, and zoom state at a glance with `display-message -p`

Use `display-message -p` with format variables to print live window metadata to stdout. Pipe it into scripts, or bind it to a key and read the result in the status line. You get the exact state without parsing `list-windows` output.

## The command

```sh
tmux display-message -p '#{window_index}:#{window_name} panes=#{window_panes} layout=#{window_layout} zoomed=#{window_zoomed_flag}'
```

## What it does

- `-p` prints the expanded format to stdout instead of the status line.
- `#{window_panes}` is the number of panes in the window.
- `#{window_layout}` is the layout string tmux uses internally, which you can save and reapply later with `select-layout`.
- `#{window_zoomed_flag}` is `1` when the active pane is zoomed and `0` otherwise.

Run it from inside a pane to describe that pane's window, or target another window with `-t`.

## Example

Describe the window that holds the current pane:

```sh
tmux display-message -p '#{window_name} has #{window_panes} panes, zoomed: #{window_zoomed_flag}'
```

Describe a specific window from a script:

```sh
tmux display-message -p -t mysession:2 '#{window_panes}'
```

Save a window's layout so you can restore it later:

```sh
layout=$(tmux display-message -p -t mysession:2 '#{window_layout}')
# later, after the layout has been changed:
tmux select-layout -t mysession:2 "$layout"
```

## Tip

Bind the command to a key so you can check the state from any pane without leaving your work:

```tmux
bind-key W display-message 'win #{window_index}: #{window_panes} panes, zoom=#{window_zoomed_flag}'
```

Press `prefix` then `W` to see the summary in the status line.
