# Create an Interactive Menu System in a Pane with Simple Bash Loops

## The Command

```bash
tmux send-keys -t pane 'while true; do echo "1) Deploy  2) Logs  3) Restart  4) Quit"; read -p "Choose: " opt; case $opt in 1) ./deploy.sh;; 2) tail -f app.log;; 3) systemctl restart app;; 4) break;; esac; done' Enter
```

## Explanation

Build interactive menu-driven workflows directly in a pane using bash `read`, `case`, and loops. No external tools needed. Perfect for creating custom dashboards, deployment helpers, or quick action menus that guide you through common tasks.

Combine with `send-keys` to:
- Create guided operational workflows
- Build mini CLIs for project-specific tasks
- Route between multiple commands without leaving the pane
- Add safety prompts before destructive actions

## Example

```bash
# Bind a key to launch a quick database manager menu
bind-key M new-window -n db -d \; send-keys -t :db \
  'while true; do clear; echo "=== Database Menu ==="; echo "1) Backup  2) Restore  3) Query  q) Exit"; read -p "? " x; case $x in 1) ./backup.sh;; 2) ./restore.sh;; 3) psql;; q) break;; esac; done' Enter

# Launch from another pane
tmux send-keys -t work:1 'C-l'  # Clear first
tmux send-keys -t work:1 './dev-menu.sh' Enter
```
