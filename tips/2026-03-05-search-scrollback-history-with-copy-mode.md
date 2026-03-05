# Search Scrollback History with Copy Mode

**Shortcut:** `Ctrl-b [` then `/` (vi mode) or `Ctrl-s` (emacs mode)

## What It Does

Tmux keeps a scrollback buffer for every pane. You can enter copy mode and search through it — perfect for finding error messages, log entries, or command output that scrolled off screen.

## Setup

Enable vi-style keys in copy mode (recommended):

```
# In ~/.tmux.conf
setw -g mode-keys vi
```

## Usage

1. Enter copy mode: `Ctrl-b [`
2. Search backward: `/` then type your pattern, press `Enter`
3. Jump to next match: `n`
4. Jump to previous match: `N`
5. Exit copy mode: `q`

To search forward (toward older output), use `?` instead of `/`.

## Concrete Example

You ran a long build and need to find the first compiler error:

```
Ctrl-b [        # enter copy mode
?error          # search backward for "error"
N               # keep jumping to earlier matches
```

Once you find it, you can select and copy the text:

```
Space           # start selection (vi mode)
Move cursor     # highlight the text you want
Enter           # copy to tmux buffer
Ctrl-b ]        # paste into any pane
```

## Bonus: Increase Scrollback Size

The default buffer is 2000 lines. For log-heavy work, bump it up:

```
# In ~/.tmux.conf
set -g history-limit 50000
```

## Quick Reference

| Key (vi mode) | Action                  |
|----------------|-------------------------|
| `Ctrl-b [`     | Enter copy mode         |
| `/pattern`     | Search forward (down)   |
| `?pattern`     | Search backward (up)    |
| `n` / `N`      | Next / previous match   |
| `Space`        | Begin selection         |
| `Enter`        | Copy selection          |
| `Ctrl-b ]`     | Paste buffer            |
| `q`            | Exit copy mode          |
