# Automate Actions on tmux Events with `set-hook`

## The Command

```
tmux set-hook [-g] <hook-name> <tmux-command>
```

## What It Does

`set-hook` lets you attach tmux commands to lifecycle events — whenever a window is created, a session closes, a pane changes, or a layout shifts, tmux can automatically run a command for you. This turns tmux into a reactive environment that adapts as you work.

## Available Hooks (Common Ones)

| Hook | Fires When |
|---|---|
| `after-new-window` | A new window is created |
| `after-new-session` | A new session starts |
| `after-split-window` | A pane is split |
| `pane-focus-in` | A pane gains focus |
| `pane-focus-out` | A pane loses focus |
| `after-resize-pane` | A pane is resized |
| `alert-activity` | Activity is detected in a monitored window |
| `session-closed` | A session is destroyed |

## Examples

**Auto-rename windows to the current command:**

```bash
tmux set-hook -g after-select-pane 'rename-window "#{pane_current_command}"'
```

**Set a distinct pane border color when switching focus:**

```bash
tmux set-hook -g pane-focus-in \
  'select-pane -P bg=colour235'
tmux set-hook -g pane-focus-out \
  'select-pane -P bg=default'
```

This gives a subtle background highlight to the active pane — much easier to track than a thin border line.

**Log every new session to a file:**

```bash
tmux set-hook -g after-new-session \
  'run-shell "echo $(date): new session #{session_name} >> ~/tmux-audit.log"'
```

**Rebalance layout after every split:**

```bash
tmux set-hook -g after-split-window 'select-layout tiled'
```

## Inspecting and Removing Hooks

List all active hooks:

```bash
tmux show-hooks -g
```

Remove a specific hook:

```bash
tmux set-hook -gu after-split-window
```

## Pro Tip

Add hooks to your `~/.tmux.conf` so they persist across sessions. You can also set hooks per-session (drop the `-g` flag) when you only want the behavior in a specific context — useful for project-specific workflows where one session runs a dev server and another handles deployment.
