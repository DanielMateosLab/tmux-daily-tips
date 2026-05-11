# Show Every Format Variable with `list-keys -T` and `show-options`

**Command:** `tmux display-message -p '#{session_name}:#{window_index}.#{pane_index}'`

Tmux exposes a rich set of **format variables** (the `#{...}` placeholders) that describe nearly every aspect of the current session, window, and pane. You can interpolate them anywhere a string is expected — status bar, pane titles, `display-message`, `if-shell` conditions, and custom bindings. The trick most people miss: you can print *any* of them on demand to debug your config or build new bindings.

## How it works

Use `display-message -p` (the `-p` flag prints to stdout instead of the status line) with a format string to inspect values live. This is the fastest way to discover what tmux knows about your current context without digging through the manpage.

## Concrete example

Drop this into your shell from inside a tmux pane:

```bash
tmux display-message -p 'session=#{session_name} win=#{window_name} pane=#{pane_current_command} cwd=#{pane_current_path} size=#{pane_width}x#{pane_height}'
```

Sample output:

```
session=work win=editor pane=nvim cwd=/Users/me/projects/api size=120x40
```

## Practical use: a smart binding

Bind a key that opens a new window in the *same directory* as the focused pane and names it after the running command:

```tmux
bind C-n new-window -c "#{pane_current_path}" -n "#{pane_current_command}"
```

## Useful variables to remember

- `#{pane_current_path}` — cwd of the shell in the active pane
- `#{pane_current_command}` — process name (`vim`, `ssh`, `node`, …)
- `#{pane_pid}` — PID of the pane's process (great with `ps`/`lsof`)
- `#{client_width}` / `#{client_height}` — terminal dimensions
- `#{session_attached}` — `1` if anyone is attached, `0` otherwise
- `#{window_zoomed_flag}` — `1` when the pane is zoomed

Pair these with `display-message -p` to prototype, then drop them into bindings or your status line once you've confirmed the value.
