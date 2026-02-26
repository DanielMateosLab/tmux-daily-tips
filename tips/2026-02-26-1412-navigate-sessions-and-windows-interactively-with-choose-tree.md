# Navigate Sessions and Windows Interactively with `choose-tree`

## The Shortcut

**Prefix + s** — open an interactive tree view of all sessions, windows, and panes.

## What It Does

`choose-tree` presents a navigable, hierarchical list of every tmux session, its windows, and their panes. You can browse, preview, and instantly switch to any target — far faster than remembering session names or window indices when you have many running.

## How to Use It

Press `Prefix + s` (default binding) to open the tree. Then:

| Key       | Action                              |
|-----------|-------------------------------------|
| `j` / `k` | Move down / up in the list         |
| `Right`   | Expand a session to show windows    |
| `Left`    | Collapse back to session level      |
| `Enter`   | Switch to the highlighted target    |
| `x`       | Kill the highlighted item           |
| `t`       | Toggle tag (mark for bulk action)   |
| `q`       | Cancel and close the tree           |

## Example

You're running three sessions — `dev`, `logs`, and `deploy` — each with multiple windows. Instead of:

```
tmux switch-client -t logs
tmux select-window -t 2
```

Just press `Prefix + s`, arrow down to **logs → window 2**, and hit `Enter`. Done.

## Window-Only Variant

**Prefix + w** opens the same tree but expanded to show all windows across all sessions. This is ideal when you care about windows, not sessions.

## Filtering the Tree

In tmux 3.1+, you can type to filter the list. Press `f` inside the tree view and type a substring — only matching sessions and windows remain visible. This is invaluable when managing 10+ sessions.

## Customizing the Display

You can control what the tree shows with format strings:

```bash
# Show session name, window count, and attached status
tmux choose-tree -F '#{session_name} (#{session_windows} windows) #{?session_attached,[attached],}'
```

## Pro Tip

Bind a quick "jump to last session" shortcut alongside `choose-tree` for fluid navigation:

```bash
# Toggle between current and previous session
bind -n M-` switch-client -l
```

Use `Prefix + s` for discovery, and `Meta + backtick` for bouncing between your two most recent sessions.
