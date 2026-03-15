# Launch Floating Popup Windows with `display-popup`

## The Command

```
Prefix + : then display-popup [-E] [-w width] [-h height] "command"
```

Or bind it for quick access:

```tmux
bind p display-popup -E -w 80% -h 70%
bind g display-popup -E -w 80% -h 70% "lazygit"
```

## What It Does

`display-popup` (tmux 3.2+) opens a **floating overlay window** on top of your current panes. It runs any command in a temporary shell, and `-E` closes the popup automatically when the command exits. This is perfect for quick tasks without disrupting your layout.

## Why It's Useful

Unlike splitting a pane, a popup floats above everything. You get a focused workspace that vanishes when you're done — no cleanup, no rearranging. Think of it as a modal dialog for your terminal.

## Practical Examples

**Quick interactive shell:**
```bash
tmux display-popup -E -w 60% -h 50%
```
Opens a centered floating shell. Press `exit` or `Ctrl-D` to dismiss.

**Git log viewer:**
```bash
tmux display-popup -E -w 90% -h 80% "git log --oneline --graph --all"
```

**Run htop without leaving your workflow:**
```bash
tmux display-popup -E -w 70% -h 60% "htop"
```

**FZF file finder that opens in vim:**
```tmux
bind f display-popup -E -w 80% -h 60% "fzf --preview 'cat {}' | xargs -r vim"
```

**Connect to a specific tmux session inside the popup:**
```bash
tmux display-popup -E -w 90% -h 80% "tmux attach -t scratch || tmux new -s scratch"
```
This gives you a nested session in a floating window — useful for a persistent scratchpad.

## Key Flags

| Flag | Purpose |
|------|---------|
| `-E` | Close popup when the command exits |
| `-w` | Width (columns or percentage, e.g. `80%`) |
| `-h` | Height (rows or percentage, e.g. `60%`) |
| `-d` | Start directory for the popup shell |
| `-T` | Title displayed at the top of the popup border |

## Recommended Bindings

```tmux
# Quick floating shell
bind C-p display-popup -E -w 80% -h 70% -d "#{pane_current_path}"

# Floating lazygit
bind C-g display-popup -E -w 90% -h 85% -d "#{pane_current_path}" "lazygit"

# Floating file picker
bind C-f display-popup -E -w 80% -h 60% -d "#{pane_current_path}" \
  "fzf --preview 'head -50 {}'"
```

Using `#{pane_current_path}` ensures the popup opens in the same directory as your active pane.
