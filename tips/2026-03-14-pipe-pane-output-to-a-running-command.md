

# Pipe Pane Output to a Running Command

## Shortcut

```
prefix + : pipe-pane -o 'cat >> ~/tmux-log.txt'
```

## What It Does

`pipe-pane` continuously streams all output from the current pane to an external command in real time. Unlike `capture-pane` (which grabs a snapshot), `pipe-pane` stays active — every new line that appears in the pane gets piped to the specified command until you turn it off.

The `-o` flag sends only the pane's output (what the shell prints), excluding your input keystrokes.

## Examples

**Log a long-running process to a file:**

```bash
# Start logging
tmux pipe-pane -o -t %3 'cat >> ~/deploy.log'

# Run your deployment
./deploy.sh production

# Stop logging (call pipe-pane with no command)
tmux pipe-pane -t %3
```

**Stream pane output through a filter:**

```bash
# Only capture lines containing "ERROR" from a busy log tail
tmux pipe-pane -o 'grep --line-buffered ERROR >> ~/errors.log'
```

**Timestamp every line of output:**

```bash
tmux pipe-pane -o 'while IFS= read -r line; do printf "%s %s\n" "$(date +%T)" "$line"; done >> ~/timestamped.log'
```

## Turning It Off

Run `pipe-pane` with no command argument to stop piping:

```bash
tmux pipe-pane
```

## How It Differs from `capture-pane`

| Feature | `capture-pane` | `pipe-pane` |
|---|---|---|
| Timing | One-time snapshot | Continuous stream |
| Future output | Not included | Captured live |
| Filtering | No | Yes (pipe to any command) |
| Must stop manually | No | Yes |

## Pro Tip

Combine with `send-keys` to script an entire session — start piping, fire commands into the pane, and collect all output into a structured log for later review or auditing.
