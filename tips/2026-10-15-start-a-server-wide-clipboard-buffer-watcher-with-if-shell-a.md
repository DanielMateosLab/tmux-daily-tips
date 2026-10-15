# Start a Server-Wide Clipboard Buffer Watcher with `if-shell` and `run-shell`

Most tmux users only think about the clipboard when they copy inside tmux. But you can have tmux watch for changes to the most recent paste buffer and mirror them to your OS clipboard automatically, so anything you yank in copy mode lands in your system clipboard too. Combine `if-shell` (to check the platform) with a `run-shell -b` background watcher to make it portable.

## The Idea

tmux stores every yank in a paste buffer. A small background loop can poll `show-buffer` and pipe any new content to `pbcopy` (macOS) or `xclip`/`wl-copy` (Linux). `if-shell` picks the right clipboard tool, and `run-shell -b` keeps the loop running without tying up a pane.

## Configuration

Add this to `~/.tmux.conf`:

```tmux
# Pick a clipboard tool based on what is installed
if-shell "command -v pbcopy" \
  "set -g @clip-cmd 'pbcopy'" \
  "if-shell 'command -v wl-copy' \
    'set -g @clip-cmd wl-copy' \
    'set -g @clip-cmd \"xclip -selection clipboard\"'"

# Run a background watcher that mirrors the newest buffer to the OS clipboard
run-shell -b 'last=""; while sleep 1; do \
  cur=$(tmux show-buffer 2>/dev/null); \
  if [ "$cur" != "$last" ]; then \
    printf "%s" "$cur" | sh -c "$(tmux show -gv @clip-cmd)"; \
    last="$cur"; \
  fi; \
done'
```

Reload with `prefix + r` (or `tmux source-file ~/.tmux.conf`).

## Example

1. Enter copy mode with `prefix + [`, select a line, and press `Enter` to yank.
2. Switch to another app and paste with `Cmd+V` (macOS). The yanked text is already there.

Because the watcher runs at the server level, it works across every session and window without per-pane setup. Stop it with `tmux kill-server` or by killing the `sleep` loop.
