

# Send Commands to All Windows with a Custom Keybinding

## The Command

```
bind -n M-a run-shell 'for w in $(tmux list-windows -F "#{window_index}"); do tmux send-keys -t ":$w" "$1" Enter; done'
```

## What It Does

While `synchronize-panes` lets you type in all **panes** of a single window simultaneously, sometimes you need to send a command to all **windows** in the current session — for example, sourcing an updated shell config, clearing screens, or running `git pull` across multiple project windows.

The `run-shell` + `list-windows` loop iterates over every window and uses `send-keys` to deliver the command to each one.

## Setup

Add this to your `~/.tmux.conf` to create a reusable prompt-based workflow:

```tmux
bind M-a command-prompt -p "Send to all windows:" \
  "run-shell 'for w in \$(tmux list-windows -F \"##{window_index}\"); do tmux send-keys -t \":$w\" \"%1\" Enter; done'"
```

Now `prefix` + `M-a` opens a prompt where you type a command, and it gets sent to every window.

## Practical Examples

**Reload shell config everywhere after editing `.zshrc`:**

```
prefix + M-a → source ~/.zshrc
```

**Clear all windows at once:**

```
prefix + M-a → clear
```

**Pull latest changes in all project windows:**

```
prefix + M-a → git pull --rebase
```

## One-Off Usage from the Command Line

You don't need a keybinding. Run it directly:

```bash
# Send "date" to every window in the current session
for w in $(tmux list-windows -F '#{window_index}'); do
  tmux send-keys -t ":$w" "date" Enter
done
```

## Targeting a Specific Session

Add `-t session_name` to scope it:

```bash
for w in $(tmux list-windows -t work -F '#{window_index}'); do
  tmux send-keys -t "work:$w" "npm run lint" Enter
done
```

## Tips

- This sends to the **active pane** of each window. Combine with `synchronize-panes` if windows have multiple panes you also want to reach.
- Use `send-keys` without `Enter` at the end if you want to stage the command without executing it — useful for destructive operations you want to review first.
- Add a short `sleep 0.1` between iterations if commands are timing-sensitive or if you're hitting rate limits on remote hosts.
