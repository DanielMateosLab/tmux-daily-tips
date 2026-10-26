# Show a tmux window's pane count in the window name with `#{window_panes}`

Tmux exposes the number of panes in a window as the format variable `#{window_panes}`. You can fold it into the automatic window name through `automatic-rename-format` (the `#{window_panes}` line from earlier tips goes in the status bar, this one goes into the name itself), so every window advertises its layout density wherever names appear: `choose-tree`, `choose-window`, and the status line.

Set the format once in your config:

```tmux
set -g automatic-rename on
set -g automatic-rename-format "#{?#{==:#{window_panes},1},#{pane_current_command},#{pane_current_command}[#{window_panes}]}"
```

A single-pane window keeps its plain command name, such as `zsh` or `nvim`. A window with three panes shows `zsh[3]` or `nvim[3]`, so you can spot a crowded window before switching to it.

Apply the change without restarting:

```tmux
tmux source-file ~/.tmux.conf
```

Existing windows pick up the new format the next time tmux renames them, which happens as soon as their running command changes. To force an immediate rename of the current window, run `tmux rename-window ""` once, which hands naming back to tmux.

Check the format before committing it to your config:

```tmux
tmux display-message -p "#{window_panes}"
```

The command prints the pane count for the current window, which confirms that the variable resolves in your tmux version.
