# Quick-toggle a utility window with a single keybinding

Bind a single key to create, focus, or close a dedicated utility window (like `htop`, notes, calculator) without cluttering your layout.

## The command

```
bind-key F2 if-shell "tmux select-window -t :utils 2>/dev/null" "if-shell '#{window_zoomed_flag}' 'send-keys -t :utils q C-m' 'kill-window -t :utils'" "new-window -t :utils -n utils 'htop'"
```

Or simpler—just create and focus:

```
bind-key F2 if-shell "tmux select-window -t :utils 2>/dev/null" "" "new-window -t :utils -n utils 'htop'"
```

## How it works

The binding checks if a window named `utils` exists. If it does, it focuses it; if not, it creates it and runs `htop`. Press the key again to hide it.

Replace `htop` with any command: `less +F /var/log/system.log`, `python`, `watch -n1 free -h`, or a custom shell function.

## Example

Add to `.tmux.conf`:

```
bind-key F2 if-shell "tmux select-window -t :utils" "" "new-window -t :utils -n utils -c #{pane_current_path} 'zsh'"
```

Now `F2` toggles a scratch shell window at your current working directory. Press `F2` again to close it with a command (`exit` or `C-d`).

## Variations

Swap windows instead of killing:

```
bind-key F2 if-shell "tmux select-window -t :utils" "swap-window -t :utils -s :$(tmux display-message -p '#I')" "new-window -t :utils -n utils"
```

Or create floating (with `display-popup`) for a true modal feel.
