# Quick copy pane output to system clipboard

**Shortcut:**
```tmux
bind C-c run "tmux capture-pane -p -S -30 | pbcopy"
```

**Explanation:**
The `set-clipboard` option only works for copy-mode selections. To quickly copy any pane's recent output to your system clipboard without entering copy-mode, combine `capture-pane -p` (print to stdout) with your system clipboard tool (`pbcopy` on macOS, `xclip` or `wl-copy` on Linux).

The `-S -30` flag captures the last 30 lines. Adjust as needed. This works seamlessly over SSH—the clipboard command executes on your local machine, not the remote host.

**Example:**
Bind it in your config:
```tmux
bind C-c run "tmux capture-pane -p -S -50 | pbcopy"
bind C-v run "tmux paste-buffer"
```

Now `<prefix> C-c` instantly copies the last 50 lines from any pane, and `<prefix> C-v` pastes. On Linux, replace `pbcopy` with `xclip -selection clipboard -i` or `wl-copy` depending on your environment.

You can also make it smarter by capturing only visible content or piping through `sed` to strip ANSI codes before copying:
```tmux
bind C-c run "tmux capture-pane -p -S -50 -e | sed 's/\x1b\\[[0-9;]*m//g' | pbcopy"
```
