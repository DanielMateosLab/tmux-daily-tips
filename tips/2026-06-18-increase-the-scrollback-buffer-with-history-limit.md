# Increase the Scrollback Buffer with history-limit

By default tmux only keeps **2000 lines** of scrollback per pane. Long build logs, test runs, or `cat`-ed files scroll right past that limit and are gone forever. Bump it up with the `history-limit` option.

## The option

```tmux
# In ~/.tmux.conf — applies to every new pane
set -g history-limit 50000
```

Reload with `tmux source-file ~/.tmux.conf` (or `prefix :` then `source-file ~/.tmux.conf`).

## Why it matters

`history-limit` is read **when a pane is created**, not when you scroll. Changing it in the config only affects panes opened afterward — existing panes keep their old buffer size. That trips people up constantly.

Each line costs memory, so don't go wild: 50000 lines across many panes adds up. A value between 10000 and 100000 is a sane sweet spot for most workflows.

## Example

Set a big buffer just for one important pane without touching your global config:

```bash
# Open a new window with a 200k-line scrollback for a noisy log tail
tmux new-window 'tmux set -p history-limit 200000 \; respawn-pane -k "tail -f /var/log/app.log"'
```

Or check what a pane is currently holding:

```bash
# Lines currently stored vs. the configured limit
tmux display-message -p '#{history_size} / #{history_limit}'
```

## Apply a new limit to the current pane immediately

Since the limit is fixed at creation, the trick to "resize" a live pane is to set the option, then respawn it (this clears the pane's contents):

```tmux
bind H command-prompt -p "history-limit:" \
  "set -p history-limit %1 ; respawn-pane -k"
```

Now `prefix H`, type a number, and the current pane restarts with the new buffer depth.

## Tip

Pair a generous limit with `prefix [` (copy mode) and `g`/`G` to jump to the very top or bottom of all that captured history.
