

# Break a Pane Out Into Its Own Window

**Shortcut:** `Prefix + !`

## What It Does

Takes the currently focused pane and promotes it into a brand-new window within the same session. The pane is removed from its original window, and the new window becomes active. If the original window had only that one pane, the window is destroyed.

This is the inverse of `join-pane`, which merges a window back into a pane.

## When to Use It

- A process in a small pane needs more screen real estate (e.g., a log tail or a debugger)
- You split too aggressively and want to undo one pane without killing the process
- You're triaging several tasks in splits and want to promote one to full focus

## Example Workflow

```bash
# You have a window with three panes: editor, server, and tests
# Focus the "tests" pane, then press:
Prefix + !
# The test runner is now in its own full-size window

# Later, bring it back into the original window as a side pane:
# From the original window, run:
tmux join-pane -s :2 -h -p 30
# This pulls window 2 back as a horizontal pane taking 30% width
```

## Command-Line Equivalent

```bash
tmux break-pane          # break current pane into a new window
tmux break-pane -d       # break it out but stay in the original window
tmux break-pane -t :1.2  # break pane index 2 from window 1
```

The `-d` flag is especially useful — it lets you "send" a pane to its own window without losing focus on what you're doing.

## Reversing It

To rejoin a broken-out pane back into another window:

```bash
# From the target window:
tmux join-pane -s :3      # pull window 3 back as a pane here
tmux join-pane -s :3 -v   # pull it in as a vertical split
```

`break-pane` and `join-pane` are complementary — learn both and you can fluidly rearrange your layout without restarting anything.
