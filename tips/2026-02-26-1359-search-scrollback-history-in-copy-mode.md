# Search Scrollback History in Copy Mode

## Shortcut

`Ctrl-b [` to enter copy mode, then `/` to search forward or `?` to search backward.

## Explanation

Every tmux pane maintains a scrollback buffer (2000 lines by default). Copy mode lets you navigate this buffer like a pager, and — critically — **search through it**. This is invaluable when you need to find a specific error message, log entry, or command output that has scrolled off screen.

Once in copy mode, tmux uses vi-style or emacs-style keybindings depending on your `mode-keys` setting. With vi keys (the default for many setups):

| Key | Action |
|-----|--------|
| `/` | Search forward (down) |
| `?` | Search backward (up) |
| `n` | Next match |
| `N` | Previous match |
| `q` | Exit copy mode |

## Setup

To ensure vi-style keys in copy mode, add to `~/.tmux.conf`:

```
setw -g mode-keys vi
```

To increase the scrollback buffer size:

```
set -g history-limit 10000
```

## Example

You ran a long build and need to find the first compilation error:

1. Press `Ctrl-b [` to enter copy mode
2. Press `?` to search backward
3. Type `error:` and press Enter
4. Press `N` to jump to earlier matches until you find the first one
5. Press `q` to exit copy mode

## Bonus: Search and Copy

While in copy mode after finding your match, you can select and copy text:

1. Press `Space` to start selection (vi mode)
2. Move the cursor to extend the selection
3. Press `Enter` to copy to the tmux paste buffer
4. Press `Ctrl-b ]` to paste the copied text into any pane

This workflow replaces piping output through `less` or `grep` in many cases — the output is already in your scrollback, just search it.
