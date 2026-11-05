# Set a different shell for new panes and windows with default-shell

Set `default-shell` to choose the program tmux starts in every new pane and window, without changing your login shell. This helps when your system shell is bash but you work in fish, or when a project needs a specific shell.

```tmux
set -g default-shell /opt/homebrew/bin/fish
```

Add the line to `~/.tmux.conf` and reload it with `tmux source-file ~/.tmux.conf`. The value must be an absolute path to an executable. To check what tmux will use, run:

```sh
tmux show -gv default-shell
```

Existing panes keep the shell they started with. Only new panes and windows pick up the change, so open a fresh window with `prefix` + `c` to test it.

To try a shell without editing the config, run this from inside tmux:

```sh
tmux set -g default-shell /bin/zsh
```

The change lasts until the server restarts, because it doesn't write to the config file.

If you want a single program instead of a shell, use `default-command`. It runs once in each new pane, and `default-shell` is ignored while it's set:

```tmux
set -g default-command "htop"
```

When `htop` exits, the pane closes. Pair it with `remain-on-exit` if you want to keep the pane open to read the output.
