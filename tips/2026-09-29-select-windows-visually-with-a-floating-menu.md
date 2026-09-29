# Select Windows Visually with a Floating Menu

Jump to any window by browsing them visually in a popup instead of typing numbers.

## Keybinding

```
bind-key w display-popup -E "tmux list-windows -F '#{window_index}: #{window_name} (#{pane_current_command})'"
```

Press `w` to show all windows with their index, name, and active command. Note the number and press it to jump.

## Interactive Selection with fzf

For automatic jumping without typing the number:

```
bind-key w run-shell "tmux list-windows -F '#{window_index}: #{window_name}' | fzf | cut -d: -f1 | xargs -I {} tmux select-window -t {}"
```

Requires `fzf`. Navigate with arrow keys and press Enter to jump to the selected window.

## Show More Details

Display pane count and dimensions:

```
bind-key w display-popup -h 20 -w 60 -E "tmux list-windows -F '#{window_index}: #{window_name} - #{window_panes} panes (#{pane_width}x#{pane_height})'"
```

## Include Active Status

Highlight the current window:

```
bind-key w display-popup -E "tmux list-windows -F '#{window_index}: #{window_name} #{?window_active,(active),}'"
```

Quickly navigate complex sessions with many windows without memorizing indices.
