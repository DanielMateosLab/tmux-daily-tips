# Synchronize Panes: Type in All Panes at Once

## The Command

`Ctrl-b :setw synchronize-panes on`

## What It Does

When synchronize-panes is enabled, every keystroke you type is sent to **all panes** in the current window simultaneously. This is incredibly useful when you need to run the same command across multiple servers or environments at the same time.

## How to Use It

1. Split your window into multiple panes, each connected to a different host:

```
ssh server-01    # pane 1
ssh server-02    # pane 2
ssh server-03    # pane 3
```

2. Enable synchronized input:

```
Ctrl-b :setw synchronize-panes on
```

3. Now type a command — it runs in every pane:

```
sudo systemctl restart nginx
```

4. Turn it off when done:

```
Ctrl-b :setw synchronize-panes off
```

## Pro Tip: Add a Key Binding

Add this to your `~/.tmux.conf` for a quick toggle:

```
bind S setw synchronize-panes
```

Now `Ctrl-b S` toggles sync mode on and off. tmux will display a brief message in the status bar confirming the state change.

## Visual Indicator

To make it obvious when sync is active, add a status bar indicator:

```
set -g status-right '#{?pane_synchronized,#[bg=red] SYNC ,}%H:%M'
```

This shows a red **SYNC** badge in your status bar whenever synchronize-panes is enabled, preventing accidental commands sent to all panes.

## When It's Useful

- Deploying the same change to multiple servers
- Checking disk space or logs across a fleet
- Running identical setup commands on fresh environments
- Comparing output side-by-side in real time
