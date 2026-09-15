# Display connected clients with custom formatting

**Command:** `tmux list-clients -F`

When multiple people share tmux sessions, know who's connected and to which pane. Use `list-clients` with a custom format string to show connection details.

## Default output

```sh
tmux list-clients
```

Shows only the terminal name. Use `-F` to customize:

```sh
tmux list-clients -F '#{client_name} → #{session_name} (#{pane_title})'
```

This prints each connected client with their session and current pane title.

## Practical examples

**Show who's on which window:**
```sh
tmux list-clients -F '#{client_name}: #{session_name}:#{window_index} [#{window_name}]'
```

**Include the host and working directory:**
```sh
tmux list-clients -F '#{client_name}@#{client_pid} → #{session_name}:#{pane_index} in #{pane_current_path}'
```

**Show timestamp of when they attached:**
```sh
tmux list-clients -F '#{client_name} attached #{client_activity_string}'
```

## Common format variables

- `#{client_name}` — Client terminal identifier
- `#{session_name}` — Session they're attached to
- `#{window_index}` / `#{pane_index}` — Current position
- `#{pane_title}` — Custom pane title
- `#{pane_current_path}` — Working directory
- `#{client_pid}` — Process ID
- `#{client_activity_string}` — When they last moved the mouse/keyboard

## Automation

Create an alias to monitor who's connected:

```sh
tmux list-clients -F '#[fg=cyan]#{client_name}#[fg=default] → #{session_name}:#{window_name}'
```
