# Open a New Window in the Current Pane's Directory

## Shortcut
```bash
tmux new-window -c '#{pane_current_path}'
```

Or bind it:
```bash
bind-key C-n new-window -c '#{pane_current_path}'
```

## Explanation
When you're deep in a nested directory and need a new window, you usually end up either manually changing directories or spawning a window at your home folder and navigating. Using the `#{pane_current_path}` format variable lets tmux read the current pane's working directory and open the new window there automatically.

This works because tmux tracks the shell's current directory through a combination of shell integration and OSC escape codes.

## Example
You're in `/home/user/project/src/components/button`. Hit your bound key (or run the command), and your new window opens in `/home/user/project/src/components/button` without any manual navigation.

Add to your config:
```bash
bind-key C-n new-window -c '#{pane_current_path}' -n "work"
```

Now `Prefix C-n` instantly creates a window in your current directory with a default name.
