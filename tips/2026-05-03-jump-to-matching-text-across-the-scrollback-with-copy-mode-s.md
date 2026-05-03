# Jump to Matching Text Across the Scrollback with `copy-mode` Search-and-Jump

**Command:** `prefix + [` then `?pattern` (or `/pattern`) and `n` / `N`

While `search-backward` itself is well known, tmux's copy mode has a powerful trick: you can jump straight into copy mode *and* land on a search match in one shot using the `-X search-backward` and `search-forward` commands from the command line. This is great for grep-like jumps without leaving your keyboard on the prefix dance.

## The Shortcut

Bind a key that drops you into copy mode and immediately searches for a pattern:

```tmux
# In ~/.tmux.conf
bind-key / copy-mode \; send-keys -X search-backward "ERROR"
bind-key ? command-prompt -p "search up:" "copy-mode \; send-keys -X search-backward '%%'"
```

Now `prefix + /` jumps to the most recent `ERROR` in scrollback, and `prefix + ?` prompts you for any pattern and jumps to it.

## Why It's Useful

- Skips the manual `prefix + [` → `Ctrl-r` → type → enter dance.
- Pairs perfectly with long-running build/test panes — bind a key to jump to the last `FAIL`, `Traceback`, or `panic:`.
- Once landed, press `n` / `N` to walk through every match.

## Concrete Example

Watching a noisy log and want to bounce between every stack trace:

```tmux
bind-key T copy-mode \; send-keys -X search-backward "Traceback"
bind-key F copy-mode \; send-keys -X search-backward "FAIL"
```

Hit `prefix + T` to teleport to the last Python traceback in the buffer, then `n` / `N` to cycle through earlier ones. Press `q` to drop back to the live shell.

## Bonus: Regex Mode

Enable extended regex matching for powerful patterns:

```tmux
bind-key R copy-mode \; send-keys -X search-backward-incremental "^\\[ERROR\\]"
```

`search-backward-incremental` updates the match as you type — ideal for hunting through dense logs where you don't know the exact string yet.
