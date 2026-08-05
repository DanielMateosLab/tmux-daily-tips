# Save and Load Paste Buffers from Files

## The Commands

```
save-buffer -b buffer-name /path/to/file
load-buffer -b buffer-name /path/to/file
```

## What It Does

`save-buffer` exports the contents of a paste buffer to a file on disk. `load-buffer` does the reverse—it reads a file and creates a new paste buffer from its contents. This is essential for persisting clipboard data, sharing buffers between sessions, or building buffer contents programmatically.

## Practical Examples

Save the most recent buffer:

```
tmux save-buffer ~/my-clipboard.txt
```

Later, restore it into a fresh session:

```
tmux load-buffer ~/my-clipboard.txt
```

Load it under a specific buffer name instead of replacing the default:

```
tmux load-buffer -b important ~/my-clipboard.txt
```

List all active buffers to see what was loaded:

```
tmux list-buffers
```

Use `paste-buffer` to insert it into a pane when needed:

```
tmux paste-buffer -b important -t my-session:0
```

## Why It Matters

This unlocks workflow automation: save buffers before detaching long-running sessions, transfer clipboard data between machines via `scp`, or generate complex commands in external scripts and inject them as buffers.
