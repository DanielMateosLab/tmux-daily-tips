# Respawn a Dead Pane Without Losing Your Layout

## The Problem

When a process in a pane exits (a server crashes, a script finishes, an SSH connection drops), the pane shows as dead. Most people close it and create a new split, losing their carefully arranged layout.

## The Command

```
respawn-pane [-k] [-t target-pane] [shell-command]
```

## How It Works

`respawn-pane` restarts a dead pane in place, preserving your exact layout. Add `-k` to kill a still-running process and restart it fresh.

**Prefix shortcut** (not bound by default — add to `~/.tmux.conf`):

```bash
# Restart the current pane with your default shell
bind R respawn-pane -k

# Or bind it to restart a specific command
bind S respawn-pane -k "ssh production-server"
```

## Examples

**Restart a dead pane with your default shell:**

```
:respawn-pane
```

**Force-restart a pane that's still running (kill + relaunch):**

```
:respawn-pane -k
```

**Restart a pane with a specific command:**

```
:respawn-pane -k "python3 manage.py runserver"
```

**Target a specific pane without switching to it:**

```
:respawn-pane -k -t 2 "npm run dev"
```

## Practical Workflow

Say you have a 3-pane layout: editor, dev server, and test watcher. Your dev server crashes. Instead of:

1. Closing the dead pane
2. Re-splitting the window
3. Resizing everything back
4. Restarting the server

Just hit your bound key (e.g., `Prefix R`) or type `:respawn-pane -k "npm start"` and you're back instantly — same pane, same position, same size.

## Bonus: Combine With Hooks

Auto-respawn panes that exit, creating self-healing layouts:

```bash
set-hook -g pane-died "respawn-pane -k"
```

This makes any pane that dies automatically restart with its original command — useful for dashboards and monitoring setups.
