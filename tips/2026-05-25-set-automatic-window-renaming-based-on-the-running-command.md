# Set Automatic Window Renaming Based on the Running Command

`setw -g automatic-rename on` and `set -g automatic-rename-format '#{b:pane_current_command}'`

By default tmux renames windows based on the foreground process, but the format is generic. You can customize `automatic-rename-format` to show exactly what you want — the basename of the current command, the working directory, or any mix of format variables. This keeps your window list informative without manual renaming.

Once you've manually renamed a window (with `,` or `rename-window`), tmux disables auto-rename for it. To re-enable, run `setw automatic-rename on` from inside that window.

## Example

Add to `~/.tmux.conf`:

```tmux
set -g automatic-rename on
set -g automatic-rename-format '#{?#{==:#{pane_current_command},zsh},#{b:pane_current_path},#{pane_current_command}}'
```

This shows the basename of the current directory when you're at a shell prompt (e.g. `my-project`), but switches to the command name when something is running (e.g. `vim`, `npm`, `psql`). The result: a status bar that always tells you what each window is actually doing.

To re-enable auto-rename on a window you've manually named:

```bash
tmux setw automatic-rename on
```

To verify the current setting for the active window:

```bash
tmux show-window-options -v automatic-rename
```

Pair this with `set -g status-interval 1` if you want the names to update more responsively when commands start and stop.
