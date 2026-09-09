# Trigger shell completion in a remote pane with Tab

You can send the `Tab` key to a remote tmux pane to trigger shell completion (bash/zsh) without switching focus or manually interacting with the pane.

**Send Tab to complete:**

```tmux
send-keys -t pane "Tab"
```

**Why:**

When automating interactions with a remote pane, trigger completion to finish file paths, command names, options, or service names. Useful for scripted workflows that need to explore what's available without manual typing.

**Example:**

Automate discovering Docker containers and stopping one:

```tmux
send-keys -t dev "docker stop " Enter
send-keys -t dev "docker ps | grep web" Enter
send-keys -t dev "docker stop my-" "Tab"  # Completes container name
```

Or complete a directory path in a remote pane:

```tmux
send-keys -t remote "cd /etc/ap" "Tab"    # Completes to /etc/apache2 or /etc/apparmor
```

**Multi-step automation:**

```tmux
send-keys -t deploy "systemctl restart " "Tab"  # Shows available services
send-keys -t deploy "ng" "Tab"                   # Completes to nginx
send-keys -t deploy Enter                        # Executes the command
```

Saves time in interactive scripts where you're guiding someone or automating remote exploration without hardcoding full paths or names.
