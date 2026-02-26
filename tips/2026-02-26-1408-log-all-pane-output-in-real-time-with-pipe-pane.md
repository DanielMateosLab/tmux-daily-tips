# Log All Pane Output in Real Time with `pipe-pane`

## The Command

```
prefix + : pipe-pane -o 'cat >> ~/tmux-pane-#{pane_id}.log'
```

Or from the shell:

```bash
tmux pipe-pane -o -t %3 'cat >> ~/debug-session.log'
```

## What It Does

`pipe-pane` streams all output written to a pane directly into an external command — in real time. Unlike `capture-pane` which grabs a snapshot, `pipe-pane` continuously records everything as it happens, making it ideal for logging long-running processes, debugging sessions, or audit trails.

The `-o` flag means "output only" — it captures what the program writes to the terminal but does not feed input back. Without `-o`, the pipe is bidirectional.

## Practical Examples

**Start logging a pane to a file:**

```bash
tmux pipe-pane -o 'cat >> ~/logs/build-output.log'
```

**Log with timestamps for each line:**

```bash
tmux pipe-pane -o 'while IFS= read -r line; do printf "%s %s\n" "$(date +%H:%M:%S)" "$line"; done >> ~/logs/timed.log'
```

**Stop logging (call with no command):**

```bash
tmux pipe-pane
```

**Target a specific pane in another window:**

```bash
tmux pipe-pane -o -t mysession:2.1 'cat >> ~/logs/server.log'
```

## Why Use This Over `capture-pane`

| Feature | `capture-pane` | `pipe-pane` |
|---|---|---|
| Timing | One-time snapshot | Continuous stream |
| Future output | Not captured | Captured live |
| Scrollback only | Yes | No — captures new output |
| Best for | Grabbing what already happened | Recording what will happen |

## Quick Keybinding

Add to `~/.tmux.conf` to toggle logging with `prefix + P`:

```tmux
bind P pipe-pane -o 'cat >> ~/tmux-#{session_name}-#{window_index}-#{pane_index}.log' \; display-message "Logging started"
bind p pipe-pane \; display-message "Logging stopped"
```

This gives you one-key log toggling — uppercase `P` to start, lowercase `p` to stop.
