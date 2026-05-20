# Start Copy Mode and Jump Straight to a Search

**Shortcut:** `prefix + /` (custom binding) or `tmux copy-mode \; send -X search-backward "pattern"`

Instead of entering copy mode (`prefix + [`) and then pressing `?` to search backward, you can bind a single key that enters copy mode *and* immediately prompts for a search term. This collapses a two-step workflow into one keystroke — useful when you frequently hunt for errors, IPs, or filenames in long scrollbacks.

## The binding

Add this to `~/.tmux.conf`:

```tmux
bind / copy-mode \; command-prompt -p "search up:" "send -X search-backward '%%'"
bind ? copy-mode \; command-prompt -p "search down:" "send -X search-forward '%%'"
```

Reload with `prefix + :` then `source-file ~/.tmux.conf`.

## How it works

- `copy-mode` enters scrollback navigation.
- `command-prompt -p "..."` opens a status-line prompt with your custom label.
- `send -X search-backward '%%'` runs the copy-mode search command with `%%` replaced by whatever you typed.

## Example

You're tailing a verbose log and want to find the last `ERROR` line:

1. Press `prefix + /`
2. Type `ERROR` and hit Enter
3. You land directly on the most recent match, already in copy mode — press `n` to jump to the next match or `q` to exit.

## Bonus: regex search

Use `search-backward-regex` instead for pattern matching:

```tmux
bind C-/ copy-mode \; command-prompt -p "regex:" "send -X search-backward-regex '%%'"
```

Now `prefix + Ctrl-/` lets you search for things like `[0-9]{3}\.[0-9]+\.[0-9]+\.[0-9]+` to find IP addresses.
