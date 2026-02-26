The user said "Existing tips (do NOT duplicate these):" with nothing listed after, meaning there are no existing tips yet. I'll generate a practical tmux tip.

# Synchronize Panes: Type in All Panes at Once

## Shortcut

```
prefix + : setw synchronize-panes on
```

(Default prefix is `Ctrl-b`)

## What It Does

Synchronize-panes broadcasts every keystroke you type to **all panes** in the current window simultaneously. This is incredibly useful when you need to run the same command across multiple servers or environments at the same time.

## When to Use It

- Running identical commands on multiple SSH sessions
- Tailing logs across several services at once
- Updating configuration on a fleet of machines
- Comparing output of the same command in different environments

## Example Workflow

**1. Set up your panes** — split into four panes, each SSH'd into a different server:

```bash
tmux split-window -h "ssh server-02"
tmux split-window -v "ssh server-03"
tmux select-pane -t 0
tmux split-window -v "ssh server-01"
```

**2. Turn on synchronization:**

Press `Ctrl-b` then type:

```
:setw synchronize-panes on
```

**3. Now type a command — it runs everywhere:**

```bash
sudo systemctl restart nginx
```

All four panes execute the restart simultaneously.

**4. Turn it off when done:**

```
:setw synchronize-panes off
```

## Pro Tip: Add a Keybinding

Add this to your `~/.tmux.conf` for a quick toggle:

```bash
bind S setw synchronize-panes \; display "Sync #{?synchronize-panes,ON,OFF}"
```

Now `Ctrl-b S` toggles sync mode and shows the current state in the status line.

## Visual Indicator

To make it obvious when sync is active, add a status bar indicator:

```bash
set -g status-right '#{?synchronize-panes,#[bg=red] SYNC ,} %H:%M'
```

This shows a red **SYNC** badge whenever panes are synchronized, so you never accidentally type into all panes without realizing it.
