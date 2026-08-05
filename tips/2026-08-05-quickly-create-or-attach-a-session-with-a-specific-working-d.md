# Quickly create or attach a session with a specific working directory

Use `new-session -A` (attach if exists) combined with `-c` to set the working directory, bypassing the need for `attach-session` or manual directory switching.

## Command

```bash
tmux new-session -A -s myapp -c ~/projects/myapp
```

## Explanation

The `-A` flag tells tmux to attach to an existing session if it exists, otherwise create a new one. The `-c` flag sets the working directory for all new panes/windows created in that session. This eliminates the three-step workflow of creating a session, attaching, and navigating to your project directory.

## Example

```bash
# Jump into a project session, creating it if needed
tmux new-session -A -s backend -c ~/work/api-service

# In another terminal, attach to the same session at its working directory
tmux new-session -A -s backend -c ~/work/api-service

# Or use it in a shell function for quick context switching
work() {
  local project="$1"
  tmux new-session -A -s "$project" -c "$HOME/projects/$project"
}

work myrepo  # Instantly switches to or creates session for myrepo
```

## Pro tip

Combine with your shell alias for even faster access:

```bash
alias tm='tmux new-session -A -s'
tm main -c ~/projects/main
```
