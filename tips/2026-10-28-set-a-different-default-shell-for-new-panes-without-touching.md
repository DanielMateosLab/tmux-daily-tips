# Set a different default shell for new panes without touching your config

Use `default-shell` to change which shell tmux launches in new panes and windows, without editing your login shell or your `.zshrc`. It's handy when you want tmux to start a specific shell (for example, a newer Homebrew bash or fish) while the rest of your system keeps its default.

## Command

```sh
tmux set-option -g default-shell /path/to/shell
```

Check the current value first:

```sh
tmux show-options -g default-shell
```

## Explanation

- `-g` sets the option globally for the server, so every new session, window, and pane uses it.
- `default-shell` only affects shells that tmux launches. Your login shell (`chsh`) and existing panes are unchanged.
- Changes apply to panes created after the change. Running panes keep their current shell.
- To make it permanent, add the line to `~/.tmux.conf`, then reload with `tmux source-file ~/.tmux.conf`.

## Example

Start new panes in fish instead of your login shell:

```sh
tmux set-option -g default-shell "$(command -v fish)"
```

Persist it in `~/.tmux.conf`:

```tmux
set -g default-shell "/opt/homebrew/bin/fish"
```

Then open a new window with `prefix c` and run `echo $FISH_VERSION` to confirm the shell.
