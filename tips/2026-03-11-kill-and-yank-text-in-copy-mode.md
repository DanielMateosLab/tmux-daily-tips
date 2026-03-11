

# Kill and Yank Text in Copy Mode

## Shortcut

In copy mode (`prefix` + `[`), use **vi-style selection and clipboard** commands:

| Key | Action |
|-----|--------|
| `Space` | Start selection |
| `Enter` | Copy selection to tmux buffer |
| `prefix` + `]` | Paste from tmux buffer |

## Why This Is Useful

tmux maintains its own paste buffer stack, completely independent of your system clipboard. You can copy multiple selections and cycle through them — think of it as a kill ring for your terminal. This is invaluable when you need to grab several pieces of output (log lines, paths, error codes) and paste them elsewhere without leaving tmux.

## Concrete Example

**Grab a specific log line and paste it into another pane:**

1. Enter copy mode: `prefix` + `[`
2. Navigate to the line you want (use `/` to search, or `k`/`j` to move)
3. Press `Space` to start highlighting
4. Move to the end of the text you want
5. Press `Enter` to yank it into the buffer
6. Switch to your target pane: `prefix` + `q` then pane number
7. Paste: `prefix` + `]`

**Stack multiple copies and list your buffers:**

```sh
# List all paste buffers (most recent first)
tmux list-buffers

# Paste from a specific buffer (e.g., buffer 2)
tmux paste-buffer -b 2

# Save a buffer directly to a file
tmux save-buffer -b 0 ~/captured-text.txt

# Delete a specific buffer
tmux delete-buffer -b 3
```

## Pro Tip: Choose a Buffer When Pasting

Instead of always pasting the most recent yank, use:

```
prefix + =
```

This opens an interactive buffer selector showing all your stored yanks. Navigate the list and press `Enter` to paste the one you want. It turns tmux into a multi-clipboard manager right in your terminal.

## Bonus: Append to a Buffer

Yank additional text into the **same** buffer instead of creating a new one:

```sh
# In copy mode, after selecting text, use:
tmux set-buffer -a -b my_notes "$(tmux show-buffer)"
```

Or simply yank multiple times and combine them:

```sh
# Concatenate the two most recent buffers
tmux set-buffer "$(tmux show-buffer -b 0)$(tmux show-buffer -b 1)"
```
