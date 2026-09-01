# Send Commands to Windows by Name Instead of Index

**Shortcut:** `send-keys -t "window_name" "command" Enter`

When sending commands to specific windows or panes, use window and pane names instead of indices. Names persist across reordering and renumbering, making scripts resilient and readable.

**Why:** Window indices shift when you create, close, or reorder windows. A script that targets `-t 3` breaks when the layout changes. Targeting by name is stable.

**Basic example:**

```bash
tmux send-keys -t "editor" "vim ." Enter
tmux send-keys -t "logs" "tail -f app.log" Enter
```

**With pane names (if you've set pane titles):**

```bash
tmux send-keys -t "server:build" "npm run dev" Enter
tmux send-keys -t "server:test.validator" "npm test" Enter
```

**Target format:** `session_name:window_name.pane_number` or just `window_name` if you're in the right session.

**Bootstrap a session with named windows:**

```bash
tmux new-session -d -s dev
tmux new-window -t dev -n editor
tmux new-window -t dev -n logs
tmux send-keys -t dev:editor "vim ." Enter
tmux send-keys -t dev:logs "tail -f var/log/app.log" Enter
```

Now your automation targets readable names that survive window reordering.
