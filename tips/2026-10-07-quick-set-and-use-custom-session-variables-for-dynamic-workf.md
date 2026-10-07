# Quick Set and Use Custom Session Variables for Dynamic Workflows

## Store Custom Data in Your Session

```bash
tmux set -g @myvar "value"
```

## Access Variables in Keybindings, Status Bar, and Commands

```bash
# Display in status bar
set -g status-right "Custom: #{@myvar}"

# Use in keybindings
bind C-x send-keys "echo #{@myvar}" Enter

# Update on-the-fly
set -g @myvar "new-value"
```

## Practical Example: Dynamic Session Paths

```bash
# Set default project path at session start
tmux new-session -s dev -c "/home/user/projects" \; set -g @project-dir "/home/user/projects"

# Jump to that path anytime
bind g send-keys "cd #{@project-dir}" Enter

# Update when switching contexts
bind G command-prompt "set -g @project-dir {}" 
```

## Why This Matters

Custom variables persist for your entire session, eliminating the need to hardcode paths, commands, or context in your keybindings. Store database names, deployment targets, or test environments once, then reference them everywhere—and update them instantly without editing your config.

Use `list-options -g` to see all session variables including yours (they start with `@`).
