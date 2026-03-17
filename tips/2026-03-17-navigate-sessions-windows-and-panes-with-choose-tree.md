# Navigate Sessions, Windows, and Panes with choose-tree

## The Shortcut

**`Prefix + s`** — open an interactive tree view of all sessions, windows, and panes.

## What It Does

`choose-tree` launches a navigable tree that shows every session, window, and pane in your tmux server. You can expand/collapse branches, preview pane contents in real-time, and instantly switch to any target by pressing Enter.

This is far faster than memorizing session names or cycling through windows when you have a complex multi-session setup.

## Key Bindings Inside choose-tree

| Key | Action |
|-----|--------|
| `Enter` | Switch to the selected item |
| `Right` / `l` | Expand a branch (show windows/panes) |
| `Left` / `h` | Collapse a branch |
| `j` / `k` | Move down / up |
| `x` | Kill the selected session, window, or pane |
| `O` | Sort items (toggles between name, index, time) |
| `/` | Search by name |
| `q` | Cancel and close |

## Variations

Show only sessions (collapsed, no windows):

```
Prefix + s
```

Show the full tree starting at window level:

```
Prefix + w
```

Launch from the command line with a custom format:

```bash
tmux choose-tree -F "#{session_name}: #{window_name} (#{pane_current_command})"
```

Filter to sessions matching a pattern:

```bash
tmux choose-tree -s -f "#{m:dev*,#{session_name}}"
```

This shows only sessions whose names start with `dev`.

## Practical Example

You're running three sessions — `backend`, `frontend`, and `infra` — each with multiple windows. Instead of:

```bash
tmux switch-client -t backend
# then Prefix + 3 to get to window 3
# then Prefix + q to pick the right pane
```

Just press **`Prefix + s`**, expand the `backend` branch with the right arrow, scroll to the exact pane you need, and hit Enter. One keystroke to open, one to jump.

## Bonus: Bind a Filtered Tree

Add to `~/.tmux.conf` to get a quick-jump to any pane across all sessions:

```bash
bind P choose-tree -Z -w
```

The `-Z` flag zooms the tree to fill the terminal, and `-w` starts at the window level so every pane is immediately visible without expanding.
