

# Set Per-Pane Titles for Easy Identification

## The Command

```
select-pane -T "my-title"
```

**Default keybinding:** None — you invoke it from the command prompt (`Prefix` + `:`) or bind your own key.

## Why It's Useful

When you have several panes open — a server, a watcher, a shell — they all look the same. Setting a descriptive title on each pane lets you instantly identify what's running where, especially when combined with `pane-border-format` to display titles in the pane borders.

## How to Use It

### Set a pane title manually

```
# From the tmux command prompt (Prefix + :)
select-pane -T "api-server"
```

### Set a title on a specific pane by target

```bash
tmux select-pane -t %3 -T "database"
```

### Display titles in pane borders

Add this to your `~/.tmux.conf`:

```tmux
set -g pane-border-status top
set -g pane-border-format " #{pane_index}: #{pane_title} "
```

This renders a label bar on top of every pane showing its index and title.

### Bind a key for quick renaming

```tmux
bind T command-prompt -p "Pane title:" 'select-pane -T "%%"'
```

Now `Prefix` + `T` opens a prompt where you type the new title.

## Concrete Example

You're running a full-stack project with three panes:

```bash
# Pane 0: frontend dev server
tmux select-pane -t 0 -T "frontend"

# Pane 1: backend API
tmux select-pane -t 1 -T "api"

# Pane 2: general shell
tmux select-pane -t 2 -T "shell"
```

With `pane-border-status` enabled, your terminal now shows:

```
┌ 0: frontend ──────────┐┌ 1: api ────────────────┐
│ vite dev running...    ││ listening on :8080      │
│                        ││                         │
├ 2: shell ──────────────┴┘                         │
│ ~/project $                                       │
└───────────────────────────────────────────────────┘
```

No more guessing which pane is which.
