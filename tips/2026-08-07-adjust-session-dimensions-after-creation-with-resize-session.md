# Adjust Session Dimensions After Creation with resize-session

**Command:** `resize-session -t <session> -x cols -y rows`

While normally you set session dimensions when creating it with `new-session`, `resize-session` lets you change width and height dynamically. Useful when your terminal resizes or you're optimizing for a specific pane layout.

## Why it matters

Sessions start at your terminal's size, but you may need to:
- Attach from a smaller/larger terminal without recreating
- Force specific dimensions for reproducible layouts across hosts
- Adjust width for dashboard-style configurations

## Examples

Resize current session to 120x40:
```
tmux resize-session -t myapp -x 120 -y 40
```

Match another terminal's dimensions dynamically:
```
tmux resize-session -t work -x $(tput cols) -y $(tput lines)
```

Force standard 80-column width for legacy compatibility:
```
tmux resize-session -t legacy -x 80 -y 24
```

Maximize width for a multi-pane dashboard:
```
tmux resize-session -t dashboard -x 200 -y 50
```

## Pro tip

Bind it to a key for quick adjustment:
```
bind-key -n C-M-r command-prompt -p "Resize to:" "resize-session -t '#S' -x '#{client_width}' -y '#{client_height}'"
```
