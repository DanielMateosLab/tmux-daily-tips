# Clone a Session for Testing or Backup

**Command:** `tmux new-session -s name -t template-session` (with optional scripting)

Clone an entire session—all windows, panes, and working directories—in one action. Useful for creating a safe copy of a working session to test destructive changes, or to back up a complex setup before risky operations.

## How it works

Use `tmux list-windows` and `tmux list-panes` to read the template session's structure, then recreate it programmatically. While tmux has no built-in clone command, you can write a small shell script to replicate windows and panes.

## Example script

```bash
clone-session() {
  local src=$1
  local dst=$2
  tmux new-session -d -s "$dst" -c "$(tmux display-message -p -t "$src" '#{pane_current_path}')"
  tmux list-windows -t "$src" -F '#{window_index}:#{window_name}' | while read -r window; do
    idx="${window%:*}"
    name="${window#*:}"
    [ "$idx" = "0" ] && tmux rename-window -t "$dst:0" "$name" || \
    tmux new-window -t "$dst" -n "$name"
  done
}

clone-session main main-backup
```

This creates `main-backup` as an exact replica of the `main` session. You can now test destructive changes on the clone while keeping the original safe.

## Use case

Clone sessions before major restructuring, OS updates, or risky deployments. If something goes wrong, switch back to the original session; if the clone succeeds, you can safely delete it.
