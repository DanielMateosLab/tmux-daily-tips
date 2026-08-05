# Show Pane Numbers Longer with display-panes -d

**Command:** `display-panes -d duration_ms`

By default, `display-panes` shows pane numbers for 1 second. The `-d` flag lets you control this duration in milliseconds, useful when you need more time to select or when teaching someone tmux.

## Example

```
# Show pane numbers for 3 seconds
bind-key q display-panes -d 3000

# Show pane numbers for 5 seconds
bind-key Q display-panes -d 5000
```

## How It Works

- **Default:** 1000ms (1 second)
- **Duration:** Specify any value in milliseconds
- **Use case:** Give yourself more time to read pane layouts before selecting

Once the timer expires, the overlay disappears and you can select a pane number (0–9) from the keyboard. If you miss the window, press your binding again to redisplay.

## Tips

- Useful for accessibility or when training others on tmux
- Combine with `pane-border-indicators` for better visual feedback
- Set a comfortable duration in your `~/.tmux.conf` as your default
