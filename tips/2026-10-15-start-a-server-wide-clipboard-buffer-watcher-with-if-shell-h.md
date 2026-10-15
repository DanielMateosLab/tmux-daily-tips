# Start a Server-Wide Clipboard Buffer Watcher with `if-shell` Hooks

Not every tmux tip needs a new keybinding. You can use `set-hook` to run a command whenever a paste buffer changes, which is handy for mirroring tmux's buffer stack to an external tool without polling.

## The Hook

tmux fires the `after-set-buffer` hook each time a buffer is created or modified. Pair it with `run-shell` to forward the newest buffer's contents somewhere else:

```tmux
set-hook -g after-set-buffer 'run-shell "tmux show-buffer | pbcopy"'
```

On every `set-buffer`, `copy-pane`, or yank, the top buffer is piped to `pbcopy` (macOS) so the system clipboard stays in sync with tmux.

## Why It's Useful

- **No polling:** the command runs only when a buffer actually changes.
- **Works with copy mode:** yanking with `y` or `Enter` in copy mode triggers the hook, so selections reach your system clipboard immediately.
- **Easy to swap targets:** replace `pbcopy` with `xclip -selection clipboard` or `wl-copy` on Linux.

## Making It Portable

Use `if-shell` to pick the right clipboard tool at config load time:

```tmux
if-shell "command -v pbcopy" \
  "set-hook -g after-set-buffer 'run-shell \"tmux show-buffer | pbcopy\"'" \
  "set-hook -g after-set-buffer 'run-shell \"tmux show-buffer | wl-copy\"'"
```

Add this to `~/.tmux.conf`, then reload with `tmux source-file ~/.tmux.conf`.

## Caveat

The hook fires for every buffer change, including ones tmux creates internally, so keep the command fast. To turn it off temporarily, run:

```tmux
set-hook -gu after-set-buffer
```
