# Selecting Text with the Mouse While Keeping Copy-Mode Bindings

## The Trick

Hold `Shift` while dragging with the mouse to bypass tmux's mouse handling entirely and use your terminal emulator's native text selection instead.

## The Explanation

When `mouse on` is set, tmux intercepts all mouse events — dragging selects text in tmux's copy mode, and releasing copies it into a tmux buffer. This is great for copying within a pane, but it gets in the way when you want to select text that spans multiple panes, grab a plain string without tmux's copy-mode formatting quirks, or paste directly into another native app without going through tmux buffers.

Holding `Shift` while clicking or dragging tells your terminal emulator (iTerm2, Terminal.app, Alacritty, kitty, WezTerm, etc.) to handle the mouse event itself, ignoring tmux's mouse mode for that action. This gives you the terminal's native selection and clipboard behavior on demand, without having to toggle `mouse off` and back on.

## Example

With mouse mode enabled in `~/.tmux.conf`:

```
set -g mouse on
```

Normal click-drag inside a pane triggers tmux copy-mode selection, copying into a tmux paste buffer (retrievable with `prefix ]`).

To instead select text natively (e.g. to copy a URL that you want in your system clipboard immediately, or to select across a pane border):

```
Hold Shift + click-drag over the text
```

Release to copy using your terminal's native clipboard mechanism, completely bypassing tmux.

## Note

Key names can vary slightly: some terminals use `Option`/`Alt` instead of `Shift` for this override — check your terminal's documentation if `Shift` doesn't work.
