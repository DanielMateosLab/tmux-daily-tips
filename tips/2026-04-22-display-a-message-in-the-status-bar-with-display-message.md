# Display a Message in the Status Bar with `display-message`

**Command:** `tmux display-message "your text"` (or prefix + `:` then `display-message ...`)

`display-message` prints a short message in tmux's status line for a few seconds without disturbing the current pane. It's invaluable for surfacing information, debugging key bindings, or inspecting tmux's internal variables via **format strings** like `#{session_name}`, `#{pane_pid}`, or `#{window_index}`.

By default the message appears briefly, controlled by the `display-time` option (milliseconds). Pass `-p` to print to stdout instead — perfect for scripting.

## Example

Show the current pane's PID and working directory at any time:

```tmux
bind-key i display-message "pane #{pane_index} • pid #{pane_pid} • #{pane_current_path}"
```

Now `prefix + i` flashes something like:

```
pane 1 • pid 48213 • /Users/you/projects/api
```

Use `-p` to capture a value in a shell script:

```bash
current_session=$(tmux display-message -p '#S')
echo "Attached to: $current_session"
```

Or make messages linger longer when debugging a config:

```tmux
set-option -g display-time 4000
```

## Why it's useful

- **Introspection** — confirm which session/window/pane you're in without leaving your current command.
- **Debugging bindings** — sprinkle `display-message` into complex key chains to see which branch fired.
- **Scriptable queries** — `tmux display-message -p` exposes *any* format variable to the shell, turning tmux into a queryable state store.
