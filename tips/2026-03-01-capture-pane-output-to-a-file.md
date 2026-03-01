# Capture Pane Output to a File

## Command

```
prefix + : capture-pane -S -3000 ; save-buffer ~/tmux-capture.txt
```

Or from the shell:

```bash
tmux capture-pane -t %0 -S -3000 -p > ~/tmux-capture.txt
```

## What It Does

Captures the visible content **and scrollback history** of a tmux pane and saves it to a file. The `-S -3000` flag grabs the last 3000 lines of scrollback. The `-p` flag (in shell mode) prints to stdout instead of a tmux buffer, making it easy to redirect.

This is invaluable when you need to save build output, debug logs, or a long-running command's results without having to scroll and manually copy.

## Practical Examples

**Save the current pane's full scrollback:**

```bash
tmux capture-pane -S - -p > ~/full-output.txt
```

The `-S -` (with a bare dash) means "from the very start of the scrollback history."

**Capture a specific pane by target:**

```bash
tmux capture-pane -t mysession:0.1 -S -500 -p > ~/pane-log.txt
```

This grabs the last 500 lines from pane 1 of window 0 in `mysession`.

**Capture and grep in one shot:**

```bash
tmux capture-pane -S -1000 -p | grep -i "error"
```

Instantly search a pane's scrollback for errors without entering copy mode.

## Quick Reference

| Flag | Purpose                                    |
|------|--------------------------------------------|
| `-S` | Start line (`-S -` for all, `-S -500` for last 500) |
| `-E` | End line (defaults to visible bottom)      |
| `-p` | Print to stdout instead of tmux buffer     |
| `-t` | Target a specific pane                     |
| `-J` | Join wrapped lines (unwrap soft wraps)     |

## Pro Tip

Add this to your `~/.tmux.conf` for a quick-save binding:

```
bind-key S capture-pane -S - \; save-buffer ~/tmux-last-capture.txt \; display "Pane captured!"
```

Now `prefix + S` instantly dumps the full pane history to a file.
