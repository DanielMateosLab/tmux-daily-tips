# Send Prefix to a Nested Tmux Session

When you SSH into a remote machine running its own tmux, keystrokes get captured by your **local** tmux. To talk to the **inner** tmux, you need to send the prefix key through.

## The Command

```
prefix + prefix (press prefix twice)
```

By default, `C-b C-b` sends a literal `C-b` to the inner session. The second keypress after that is interpreted by the remote tmux.

## How It Works

tmux ships with this binding out of the box:

```
bind C-b send-prefix
```

So pressing `C-b` activates your local tmux, then `C-b` again sends the prefix character to whatever is running inside the pane — your nested tmux.

## Practical Example

You're SSH'd into a server and attached to a remote tmux session:

```bash
# Local machine → remote machine
ssh server01
tmux attach -t work
```

Now you have tmux-inside-tmux. To operate on each level:

| Action | Keys |
|---|---|
| New window in **local** tmux | `C-b c` |
| New window in **remote** tmux | `C-b C-b c` |
| Split pane in **local** tmux | `C-b %` |
| Split pane in **remote** tmux | `C-b C-b %` |
| Detach **remote** tmux | `C-b C-b d` |

## Pro Tip: Use a Different Prefix for the Inner Session

To avoid the double-tap, remap the prefix on the remote machine to something else, like `C-a`:

```bash
# In ~/.tmux.conf on the REMOTE machine
set -g prefix C-a
unbind C-b
bind C-a send-prefix
```

Now the two levels have distinct prefixes — no ambiguity:

- `C-b` → local tmux
- `C-a` → remote tmux

## Visual Hint: Style the Status Bar by Nesting Depth

Add this to the **remote** `~/.tmux.conf` to make the inner session visually distinct:

```bash
set -g status-style "bg=colour52,fg=white"
```

A different-colored status bar instantly tells you which tmux level you're interacting with — saving you from accidentally closing the wrong session.
