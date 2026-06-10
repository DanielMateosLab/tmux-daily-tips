---
title: Manage shell environment variables with set-environment
date: 2026-06-10
---

# Manage Shell Environment Variables with `set-environment`

tmux keeps its own copy of environment variables for each session and injects
them into every new pane's shell. With `set-environment` you can change a
variable once and have every *future* pane pick it up — no editing of
`~/.bashrc` and no restarting the server.

## The commands

```
# Set a session variable (visible to new panes)
tmux set-environment API_URL https://staging.example.com

# Set a GLOBAL variable (all sessions, -g)
tmux set-environment -g EDITOR nvim

# Remove a variable
tmux set-environment -u API_URL

# Inspect what tmux will hand to new shells
tmux show-environment          # session scope
tmux show-environment -g       # global scope
```

## Why it matters

Variables already exported in a running shell are **not** updated retroactively
— `set-environment` only affects shells started afterward. This makes it perfect
for switching contexts mid-work: flip a variable, open a fresh pane, and the new
shell inherits the change while your old panes keep their original values.

## Concrete example

You are debugging against staging, then need a pane pointed at production:

```
# In your current session
tmux set-environment API_URL https://staging.example.com
# ... open a pane, run your tool, it sees staging ...

# Now switch the target for the NEXT pane only
tmux set-environment API_URL https://prod.example.com
```

Split a new pane (`prefix %`) and check:

```
$ echo $API_URL
https://prod.example.com
```

Your staging pane still shows the staging URL — two environments side by side,
no shell-config juggling.

## Bonus: control what carries across reattach

The `update-environment` option lists variables tmux refreshes when a client
reattaches (handy after reconnecting over SSH from a new terminal):

```
tmux set -g update-environment "DISPLAY SSH_AUTH_SOCK SSH_CONNECTION TERM"
```

New panes created after reattaching then inherit the *current* `DISPLAY`,
keeping GUI forwarding and agent sockets working across reconnects.
