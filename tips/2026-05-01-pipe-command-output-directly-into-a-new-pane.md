# Pipe Command Output Directly Into a New Pane

Use `split-window` with a shell command to launch a pane that runs your command immediately, instead of splitting and then typing the command yourself.

## Shortcut / Command

```
tmux split-window -h "command-to-run"
tmux split-window -v "tail -f /var/log/syslog"
```

You can bind it to a key for instant access:

```
bind L split-window -v -p 30 "tail -f ~/app/logs/development.log"
```

## Explanation

When you pass a shell command as the final argument to `split-window`, tmux creates the new pane and runs that command directly inside it — no shell prompt, no typing. When the command exits, the pane closes automatically (unless you pair it with `remain-on-exit`).

This is great for:

- Tailing logs alongside your editor
- Running test watchers next to your code
- Launching `htop`, `btop`, or `watch` in a side panel
- Building reusable layouts via scripts

The `-p 30` flag sets the new pane to 30% of the available space, so your main pane keeps most of the screen.

## Concrete Example

You're editing a Rails app and want a log tail beside your editor. From inside tmux:

```
:split-window -h -p 25 "tail -f log/development.log"
```

A 25%-wide pane appears on the right, already streaming logs. Close it with `Ctrl-D` or `prefix + x` when you're done — no prompt to clean up.

Combine several into a startup script for a project:

```bash
#!/usr/bin/env bash
tmux new-session -d -s dev -n code "nvim ."
tmux split-window -t dev:code -h -p 30 "tail -f log/development.log"
tmux split-window -t dev:code.1 -v -p 50 "bin/rails server"
tmux attach -t dev
```

One command rebuilds your full working layout with every process already running.
