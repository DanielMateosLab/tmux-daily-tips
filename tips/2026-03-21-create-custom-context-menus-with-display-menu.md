# Create Custom Context Menus with `display-menu`

## The Command

```
tmux display-menu [-T title] [-x position] [-y position] name key command ...
```

**Default binding:** None — you define your own.

## What It Does

`display-menu` lets you build interactive popup menus inside tmux. Each menu entry has a display name, a shortcut key, and a tmux command to run when selected. This is perfect for grouping related actions behind a single keybinding instead of memorizing dozens of shortcuts.

## How to Use It

Add a custom menu to your `~/.tmux.conf`:

```bash
bind-key < display-menu -T "#[align=centre]Pane Actions" \
  "Horizontal Split"   h "split-window -h" \
  "Vertical Split"     v "split-window -v" \
  "" \
  "Swap Up"            u "swap-pane -U" \
  "Swap Down"          d "swap-pane -D" \
  "" \
  "Toggle Zoom"        z "resize-pane -Z" \
  "Break to Window"    b "break-pane" \
  "" \
  "Kill Pane"          x "kill-pane"
```

Now press `Prefix <` to open a navigable menu. Use arrow keys or the shortcut letter to pick an action. The empty `""` entries create visual separator lines.

## A Practical Session Manager Menu

```bash
bind-key S display-menu -T "#[align=centre]Sessions" \
  "New Session"        n "command-prompt -p 'Name:' 'new-session -s %%'" \
  "Kill Session"       k "confirm-before kill-session" \
  "" \
  "Switch: main"       m "switch-client -t main" \
  "Switch: dev"        d "switch-client -t dev" \
  "Switch: logs"       l "switch-client -t logs" \
  "" \
  "Detach"             q "detach-client"
```

## Positioning the Menu

Use `-x` and `-y` to control where the menu appears:

```bash
# Appear at the mouse cursor position
bind-key MouseDown3Pane display-menu -T "Quick" -x M -y M \
  "Copy Mode"  c "copy-mode" \
  "Clear"      r "clear-history" \
  "Kill"       x "kill-pane"
```

The `M` value means "mouse position," so this gives you a right-click context menu.

## Key Details

- Menu entries: `"Display Name" shortcut-key "tmux-command"`
- Separators: a single empty string `""`
- `-T` sets the title (supports tmux format strings like `#S`, `#W`)
- `-x` / `-y` accept: numbers, `C` (center), `R` (right), `P` (pane position), `M` (mouse), `W` (window position in status line)
- Press `q` or `Escape` to dismiss without selecting

## Why This Is Useful

Instead of remembering that `Prefix {` swaps up and `Prefix }` swaps down and `Prefix !` breaks a pane, you put them all in one discoverable menu. It's especially helpful for commands you use occasionally — frequent enough to want quick access, rare enough to forget the binding.
