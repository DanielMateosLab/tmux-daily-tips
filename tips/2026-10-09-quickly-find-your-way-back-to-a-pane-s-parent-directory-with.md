# Quickly Find Your Way Back to a Pane's Parent Directory with `pane_current_path` and `-c`

Need to start work in the same directory as an existing pane? Instead of typing `cd` or remembering the path, read the pane's current path with a format variable and use it when splitting or creating a window.

## How It Works

tmux tracks each pane's working directory through the `pane_current_path` format variable. You can pull it into a command with `#{...}` expansion and pass it to `-c`, which sets the start directory for new panes and windows.

- `split-window -c <dir>` opens a new pane in `<dir>`
- `new-window -c <dir>` opens a new window in `<dir>`
- `#{pane_current_path}` expands to the active pane's directory when used in a `run-shell` or `display-message` context

## Example

Add these bindings to `~/.tmux.conf`:

```
# Split horizontally, starting in the current pane's directory
bind-key '"' split-window -v -c "#{pane_current_path}"

# Split vertically, starting in the current pane's directory
bind-key % split-window -h -c "#{pane_current_path}"

# Open a new window in the current pane's directory
bind-key c new-window -c "#{pane_current_path}"
```

Reload with `prefix` + `:` then `source-file ~/.tmux.conf`, or run:

```sh
tmux source-file ~/.tmux.conf
```

Now, while working in `~/projects/api/src`, pressing `prefix` + `%` opens a new pane already sitting in `~/projects/api/src`, with no `cd` needed.

## Tip

`pane_current_path` depends on the shell reporting its directory. If a pane is running a program that changes its working directory without the shell knowing, the value may be stale. Verify with:

```sh
tmux display-message -p '#{pane_current_path}'
```
