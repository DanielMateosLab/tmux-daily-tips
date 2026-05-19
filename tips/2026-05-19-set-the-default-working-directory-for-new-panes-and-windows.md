# Set the Default Working Directory for New Panes and Windows

**Command:** `attach-session -c <path>` (or set `default-path` per session)

By default, new panes and windows inherit the current working directory of the pane they were created from. If you want every new pane/window in a session to start in a specific project directory regardless of where you currently are, update the session's default path with `attach-session -c`. This is far more reliable than `cd`-ing manually or relying on shell history.

## Why it's useful

- Keeps a long-lived session "anchored" to a project root even after you wander into `/tmp` or `node_modules`.
- Works retroactively — you don't need to recreate the session.
- Combines well with project-per-session workflows.

## Example

Anchor the current session to `~/code/myapp`:

```
tmux attach-session -t . -c ~/code/myapp
```

Or from inside tmux, via the command prompt (`prefix + :`):

```
attach -c #{pane_current_path}
```

The second form "pins" the session to wherever you happen to be right now — handy after `cd`-ing into a new project.

## Bind it for one-keystroke pinning

Add to `~/.tmux.conf`:

```
bind P attach -c "#{pane_current_path}" \; display "Session anchored to #{pane_current_path}"
```

Now `prefix + P` re-anchors the session to your current directory. Every subsequent `prefix + c` (new window) or `prefix + "` / `%` (split) opens there, no matter how deep you've navigated.

## Verify it

```
tmux display-message -p '#{session_path}'
```

Prints the session's current default path so you can confirm the anchor took effect.
