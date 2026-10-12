# Split a pane above or to the left with `split-window -b`

By default, `split-window` puts the new pane below the current pane (`-v`) or to its right (`-h`). Adding `-b` flips that: the new pane goes above (with `-v`) or to the left (with `-h`).

```
tmux split-window -b -v
tmux split-window -b -h
```

This is useful when the pane you want to keep busy sits at the bottom or right of the window, and the new pane should not push it further away. A log or REPL at the top of a window works well with `-b`.

## Example

Run a build watcher in a small pane above your editor:

```
tmux split-window -b -v -l 10 'npm run watch'
```

`-l 10` sets the new pane to 10 rows, and the shell command runs in it. Focus stays on the new pane, so add `-d` to keep focus on your editor.

## Bind it to a key

To split above with one keystroke in your `~/.tmux.conf`, bind `K` (unbound by default) and start the new pane in the current directory:

```
bind-key K split-window -v -b -c "#{pane_current_path}"
```

Reload with `prefix` then `:source-file ~/.tmux.conf`, or use the `source-file` shortcut covered elsewhere in this series. Press `prefix` then `K` to open a pane above the current one, in the same directory.

## Combine with percentages

For a left-side sidebar that takes a third of the window:

```
tmux split-window -b -h -p 33
```

Use `-p` for a percentage of the window instead of an absolute size with `-l`. Both work with `-b`, so choose whichever matches how you think about the layout.
