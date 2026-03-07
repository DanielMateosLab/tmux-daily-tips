# Rename Windows and Sessions on the Fly

## Shortcuts

- `Prefix + ,` — Rename the current window
- `Prefix + $` — Rename the current session

## Why It Matters

Default window names like `0:bash` or `1:zsh` become useless fast when you have 5+ windows open. Renaming gives you instant visual context in the status bar so you can navigate without guessing.

Similarly, when running multiple sessions (e.g., one per project), naming them lets `tmux switch-client` and `tmux choose-session` actually make sense.

## Usage

### Rename a window interactively

Press `Prefix + ,`, then type the new name and hit Enter:

```
Prefix + ,
api-server⏎
```

Your status bar updates from `2:node` to `2:api-server`.

### Rename a session interactively

Press `Prefix + $`, type the new name, and confirm:

```
Prefix + $
frontend-app⏎
```

### Rename from the command line

```bash
# Rename window 3 in the current session
tmux rename-window -t 3 "logs"

# Rename a specific session
tmux rename-session -t 0 "backend"
```

### Prevent automatic window renaming

By default, tmux may override your custom name when a new command runs. Disable this in `~/.tmux.conf`:

```tmux
set-option -g allow-rename off
```

Or per-window:

```tmux
set-window-option -g automatic-rename off
```

## Practical Workflow

```bash
# Start a session with a meaningful name from the start
tmux new-session -s project-x

# Create named windows as you go
tmux new-window -n "editor"
tmux new-window -n "tests"
tmux new-window -n "docker"
```

Now your status bar reads: `0:zsh  1:editor  2:tests  3:docker` — instantly scannable.
