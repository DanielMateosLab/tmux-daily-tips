# Pipe the Current Pane's Buffer to a Command with `capture-pane -p`

## The Command

```
tmux capture-pane -p | <command>
```

Or bind it for instant access:

```
bind-key C-g run-shell "tmux capture-pane -p | grep -oE 'https?://[^ ]+' | tail -1 | pbcopy"
```

## Explanation

While `capture-pane` is often used with `-S` and `-E` to dump scrollback to a file, the lesser-known `-p` flag prints the captured content directly to **stdout** instead of saving it to a paste buffer. This makes `capture-pane` composable with standard Unix pipelines — you can grep, awk, sed, or otherwise transform what's currently on screen without ever leaving tmux.

Combined with `run-shell`, this turns any visible pane content into a data source you can act on with a single keypress: extract URLs, copy the last error, parse a build's output, send text to a notification system, or feed it into `fzf`.

## Concrete Example

Bind `prefix + U` to extract the last URL visible on screen and copy it to your system clipboard (macOS):

```tmux
bind-key U run-shell "tmux capture-pane -p -S -2000 | \
  grep -oE 'https?://[a-zA-Z0-9./?=_%:-]+' | \
  tail -1 | tr -d '\\n' | pbcopy && \
  tmux display-message 'URL copied'"
```

Now press `prefix + U` after a `git push`, `gh pr create`, or any command that printed a URL — the most recent one lands in your clipboard, ready to paste into a browser. Swap `pbcopy` for `xclip -selection clipboard` on Linux or `wl-copy` on Wayland.

For a one-shot ad-hoc use, just run from any shell inside tmux:

```sh
tmux capture-pane -p -S -1000 | grep ERROR | wc -l
```

That counts every `ERROR` line in the last 1000 lines of scrollback — no file, no buffer, no detour.
