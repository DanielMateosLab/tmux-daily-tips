# Set a different default shell for new panes without touching your login shell

**Option:** `default-shell` (and the more specific `default-command`)

`default-shell` sets the program tmux launches in every new pane and window. Your login shell stays the same, so only tmux sessions change. `default-command` takes a full command string instead of a path, which is useful for wrapping the shell in extra setup.

Changes apply only to panes created afterward. Existing panes keep their current shell.

## Example

Set the default shell in `~/.tmux.conf`. The path must be absolute:

```tmux
# Launch fish in new panes and windows, while the login shell stays zsh
set -g default-shell /opt/homebrew/bin/fish
```

To change it on a running server without editing the config, use the command prompt or the CLI:

```sh
tmux set -g default-shell /bin/zsh
tmux new-window     # opens a zsh window
```

Check the current value:

```sh
tmux show-options -g default-shell
```

## Running a wrapper with default-command

If you need setup before the shell starts, such as loading a Python virtualenv or sourcing a project env file, use `default-command`:

```tmux
set -g default-command "zsh -c 'source ~/.work-env; exec zsh -l'"
```

`exec` replaces the wrapper process with the shell, so `Ctrl-d` in the pane exits cleanly instead of leaving a stray parent process.

## When to use it

- You want a different shell inside tmux, such as `fish` or `nu`, but scripts and cron jobs still expect your default login shell.
- You want every new pane to start with the same environment without repeating setup in each pane.
