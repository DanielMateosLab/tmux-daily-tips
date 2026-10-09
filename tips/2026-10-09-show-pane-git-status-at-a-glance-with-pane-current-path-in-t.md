# Show Pane Git Status at a Glance With `#{pane_current_path}` in the Status Bar

Most tmux users want to know *where* a pane is working, but a quick look at the status bar can tell you more: the directory name plus whether that directory is a dirty git repo. You can build this with a format string and `#()` command substitution, no plugin required.

## The Approach

Combine `#{pane_current_path}` (the pane's current working directory) with a shell snippet inside `#()` that checks git state. tmux runs the snippet periodically and shows the output in the status line.

Add this to `~/.tmux.conf`:

```tmux
set -g status-interval 5
set -g status-right '#{?#{==:#{pane_current_command},git},,}#(cd "#{pane_current_path}" 2>/dev/null && git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo "⎇ $(git branch --show-current) $(git diff --quiet 2>/dev/null || echo '*')" ) #[fg=cyan]%H:%M'
```

Reload the config:

```tmux
tmux source-file ~/.tmux.conf
```

## What It Shows

When the active pane is inside a git repository, the status bar displays the branch name. A trailing `*` appears when there are unstaged changes.

```
⎇ main *  14:32
```

Outside a repo, the git segment is empty and only the clock shows.

## Notes

- `#()` output runs every `status-interval` seconds. Keep the command fast; slow git operations on large repos will lag the status bar.
- `#{pane_current_path}` refers to the pane that is active when the status line refreshes, so the segment follows you as you switch panes.
- For a cleaner look, pair this with `set -g status-right-length 80` so longer branch names are not truncated.
