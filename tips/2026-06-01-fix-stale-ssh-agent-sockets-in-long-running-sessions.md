# Fix Stale SSH Agent Sockets in Long-Running Sessions

`set-environment` + `update-environment`

When you detach a tmux session, reconnect over a new SSH connection, and reattach, your `$SSH_AUTH_SOCK` inside tmux still points at the *old*, now-dead agent socket. Git pushes and `ssh` suddenly stop finding your keys. tmux can keep this variable fresh for you.

## The command

```
# In your shell, after reattaching, refresh just one pane:
eval "$(tmux show-environment -s SSH_AUTH_SOCK)"
```

But the durable fix is to tell tmux to (a) update the session environment on attach and (b) point `SSH_AUTH_SOCK` at a stable symlink instead of the volatile per-connection path.

## Permanent setup (`~/.tmux.conf`)

```
# Re-import these from the latest client on every attach
set -g update-environment "SSH_AUTH_SOCK SSH_CONNECTION DISPLAY"
```

Then point the agent at a fixed path your shell maintains (in `~/.bashrc` / `~/.zshrc`):

```sh
if [ -n "$SSH_AUTH_SOCK" ] && [ "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent.sock" ]; then
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/agent.sock"
fi
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
```

Now tmux panes always read the stable symlink, and each new SSH connection repoints it at its live agent.

## Manual override on the fly

You can also set a variable for the whole session by hand:

```
tmux set-environment SSH_AUTH_SOCK /tmp/ssh-XXXX/agent.1234
```

New panes opened afterward inherit the updated value. Inspect what tmux currently holds with:

```
tmux show-environment        # session environment
tmux show-environment -g     # global environment
```

## Why it matters

`update-environment` only refreshes the variables in *newly created* panes — existing shells keep their stale copy until you re-source them. Combining it with the symlink trick means even old panes resolve to a working agent, so you never have to think about it again.
