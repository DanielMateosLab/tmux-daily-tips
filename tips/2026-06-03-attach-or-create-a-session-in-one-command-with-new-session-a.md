# Attach or Create a Session in One Command with `new-session -A`

The `-A` flag makes `new-session` behave like `attach-session` if the target session already exists — otherwise it creates it. No more "duplicate session" errors or scripting `has-session` checks.

## The command

```bash
tmux new-session -A -s main
```

- If a session named `main` exists, you attach to it.
- If it doesn't, tmux creates it and then attaches.

Add `-d` to create-or-leave-running without attaching, which is handy in startup scripts:

```bash
tmux new-session -A -d -s work
```

## Why it's useful

This single idempotent command is perfect for shell aliases and dotfiles. Before `-A`, the common pattern was a clunky guard:

```bash
# The old way
tmux has-session -t main 2>/dev/null && tmux attach -t main || tmux new -s main
```

With `-A` that whole line collapses into one robust command that does the right thing whether or not the session is already running.

## Concrete example

Drop this in your `.bashrc` or `.zshrc` so opening a terminal always lands you in a persistent `main` session:

```bash
# Reuse 'main' if it exists, create it otherwise
if [ -z "$TMUX" ]; then
  tmux new-session -A -s main
fi
```

Now every new terminal window joins the same long-lived session, keeping your panes, history, and running processes intact across reconnects. Combine it with a project name to get one session per project:

```bash
alias dev='tmux new-session -A -s "$(basename "$PWD")"'
```

Run `dev` inside any project directory and you'll attach to that project's session — or spin it up on the first call.
