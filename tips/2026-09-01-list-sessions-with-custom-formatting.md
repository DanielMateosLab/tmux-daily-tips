# List Sessions with Custom Formatting

Get formatted session info without piping through awk or sed. Use `-F` to control output columns.

## The Command

```bash
tmux list-sessions -F "#S | #{session_windows} windows | #{session_attached} clients"
```

## Output

```
main | 4 windows | 1 client
dev | 2 windows | 0 clients
debug | 1 window | 1 client
```

## Useful Format Variables

- `#S` — session name
- `#{session_windows}` — window count
- `#{session_attached}` — attached client count
- `#{session_created}` — creation timestamp
- `#{session_active_window}` — index of active window
- `#{session_width}` — session width  
- `#{session_height}` — session height

## Practical Examples

List only sessions with running clients:

```bash
tmux list-sessions -F "#{?session_attached,#S (#{session_windows} windows),}"
```

Get session info for scripts:

```bash
tmux list-sessions -F "#{session_name}:#{session_windows}:#{session_attached}"
```

Show active window index:

```bash
tmux list-sessions -F "#S [window #{session_active_window}]"
```

## Bind to a Key

Add to `.tmux.conf` for quick session info in a popup:

```tmux
bind L display-popup -w 70 -h 20 "tmux list-sessions -F '#{session_name:15} | #{session_windows} windows | #{session_attached} attached'"
```

Press `prefix + L` to see all sessions with metadata at a glance.
