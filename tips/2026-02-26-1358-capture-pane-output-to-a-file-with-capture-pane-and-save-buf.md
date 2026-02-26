

# Capture Pane Output to a File with `capture-pane` and `save-buffer`

## The Problem

You're watching logs scroll by in a tmux pane, or you just ran a long command with useful output. You want to save what's on screen (or the entire scrollback history) to a file — without re-running anything.

## The Commands

```bash
# Capture the visible pane content to a tmux buffer
tmux capture-pane -p > output.txt

# Capture the ENTIRE scrollback history (not just visible lines)
tmux capture-pane -pS - > full_output.txt
```

### Key Flags

| Flag | Purpose |
|------|---------|
| `-p` | Print to stdout instead of a tmux paste buffer |
| `-S -` | Start capture from the very beginning of scrollback |
| `-E -` | End capture at the very bottom of scrollback |
| `-t %3` | Target a specific pane (by ID) instead of the current one |
| `-J` | Join wrapped lines (unwrap soft line breaks) |

## Practical Examples

### Save visible output of the current pane

```bash
tmux capture-pane -p > ~/build-log.txt
```

### Save full scrollback with unwrapped lines

```bash
tmux capture-pane -pS - -J > ~/debug-session.txt
```

### Capture output from a different pane

First, find pane IDs:

```bash
tmux list-panes -a -F "#{pane_id} #{pane_current_command}"
```

Then capture from a specific pane:

```bash
tmux capture-pane -pS - -t %5 > ~/server-logs.txt
```

### Using the tmux prefix binding (interactive)

From inside tmux, you can also do it in two steps:

1. `Prefix + :` then type `capture-pane -S -`
2. `Prefix + :` then type `save-buffer ~/output.txt`

## Bonus: Bind It to a Key

Add to `~/.tmux.conf` for one-key capture:

```tmux
bind-key W capture-pane -S - \; save-buffer ~/tmux-capture.txt \; display "Pane saved to ~/tmux-capture.txt"
```

Now `Prefix + W` dumps your entire pane history to a file instantly.

## When This Is Useful

- Grabbing CI/build output that's already scrolled past
- Saving a debugging session for later review or sharing
- Logging output from a long-running process without piping it upfront
- Extracting terminal content from a pane you can't easily re-run
