

# Use `copy-pipe` to Send Selected Text Directly to a Command

## The Feature

In copy mode, `copy-pipe` lets you pipe your selected text to any shell command **and** copy it to the tmux paste buffer simultaneously. This is far more powerful than copying and then manually piping — it turns tmux into a text-routing tool.

## Default Usage

There is no default keybinding — you bind it yourself in `~/.tmux.conf`:

```tmux
bind-key -T copy-mode-vi y send-keys -X copy-pipe "pbcopy"
```

Now, when you select text in copy mode and press `y`, the selection is:

1. Copied to the tmux paste buffer (so `prefix + ]` still works)
2. Piped to `pbcopy` (so it lands on your system clipboard)

## Syntax

```
send-keys -X copy-pipe[-and-cancel] "command"
```

- `copy-pipe` — pipes and stays in copy mode
- `copy-pipe-and-cancel` — pipes, copies, and exits copy mode (usually what you want)

## Practical Examples

### Send selection to system clipboard (macOS / Linux)

```tmux
# macOS
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"

# Linux (X11)
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"

# Linux (Wayland)
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "wl-copy"
```

### Append selected text to a notes file

```tmux
bind-key -T copy-mode-vi N send-keys -X copy-pipe-and-cancel \
  "cat >> ~/tmux-notes.md"
```

Select a block of text, press `N`, and it gets appended to your notes file.

### Open selected URL in a browser

```tmux
bind-key -T copy-mode-vi U send-keys -X copy-pipe-and-cancel \
  "xargs open"
```

Highlight a URL, press `U`, and it opens directly in your default browser.

### Search selected text on the web

```tmux
bind-key -T copy-mode-vi G send-keys -X copy-pipe-and-cancel \
  "xargs -I{} open 'https://www.google.com/search?q={}'"
```

## Why This Matters

Without `copy-pipe`, getting tmux selections into external tools requires multiple steps: copy, exit copy mode, paste into a command. With `copy-pipe`, a single keypress routes text wherever it needs to go — clipboard, file, browser, or any arbitrary command. It turns copy mode selections into a lightweight Unix pipeline.
