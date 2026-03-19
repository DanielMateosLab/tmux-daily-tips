# Respawn Dead Panes Instead of Closing Them

## The Command

```
set-option remain-on-exit on
```

Then revive a dead pane with:

```
respawn-pane [-k] [-c start-directory] [shell-command]
```

## What It Does

By default, when a process in a tmux pane exits, the pane closes immediately. This means you lose all the scrollback output — problematic when a long build fails and you want to inspect the errors before retrying.

Setting `remain-on-exit on` keeps the pane open after its process exits, displaying `(dead)` in the status. You can then scroll through the output, investigate what happened, and **respawn** the pane to run the command again (or a different one) without losing your layout.

## Usage

Enable it for the current window:

```bash
# From the tmux command prompt (prefix + :)
set remain-on-exit on
```

Or per-pane using `set -p`:

```bash
tmux set -p remain-on-exit on
```

When a pane dies, you'll see `(dead)` in the pane border. Respawn it:

```bash
# Re-run the original command
tmux respawn-pane

# Force-kill a still-running pane and restart it
tmux respawn-pane -k

# Respawn with a different command
tmux respawn-pane 'make test'

# Respawn in a different directory
tmux respawn-pane -c ~/project 'cargo build'
```

## Practical Example

Running a flaky integration test suite across multiple panes:

```bash
# Create a 3-pane layout, each running a test shard
tmux set remain-on-exit on
tmux split-window 'pytest tests/ -k "shard1"'
tmux split-window 'pytest tests/ -k "shard2"'

# When shard2 fails, scroll up to read the traceback,
# then respawn just that pane:
tmux respawn-pane -t %5 'pytest tests/ -k "shard2" -x --pdb'
```

## Bind It for Quick Access

```bash
# Add to ~/.tmux.conf
bind R respawn-pane -k \; display "Pane respawned"
```

Now `prefix + R` instantly restarts whatever was running in the current pane — great for edit-compile-run loops where you want to keep your layout intact.
