# Preview Any Pane Full-Screen with `display-panes` Alternatives — Meet `Prefix + w` Preview

`Prefix + w` opens the window chooser, but its real superpower is the **live preview pane** that shows you what's actually running inside each window and pane before you jump.

## The shortcut

```
Prefix + w
```

Then use `↑`/`↓` (or `j`/`k` in vi mode) to move through the tree. The bottom half of the screen renders a live preview of whatever is highlighted.

## Why it matters

Window names lie. Three windows named `zsh` tell you nothing. A window renamed `server` might have finished running the server twenty minutes ago. The preview shows the actual pane contents — the last build error, the running log tail, the idle prompt — so you pick the right target on the first try instead of cycling through windows with `Prefix + n` until something looks familiar.

## Controlling the preview

The preview is on by default in the tree mode chooser. You can tune how much space it takes:

```tmux
# Give the preview more room (percentage of the window height)
bind w choose-tree -Zw
```

The `-Z` flag zooms the chooser pane to full screen, so both the tree and the preview get maximum space. The `-w` flag starts the chooser collapsed to the window level rather than showing every session.

To disable the preview entirely when you want a dense list:

```tmux
bind W choose-tree -ZN
```

`-N` turns the preview off.

## Concrete example

You're running a four-window session:

```
0: editor   — nvim, file open
1: server   — npm run dev, crashed 5 min ago
2: server   — npm run dev, healthy
3: shell    — idle prompt
```

Windows 1 and 2 have identical names. Hit `Prefix + w`, arrow down to window 1, and the preview shows:

```
Error: listen EADDRINUSE: address already in use :::3000
```

Arrow down once more to window 2 and the preview shows:

```
✓ ready in 412 ms
  ➜ Local: http://localhost:3000/
```

Now you know exactly which one to kill and which one to keep. Press `x` right there in the chooser to kill window 1 without ever attaching to it, then `Enter` on window 2 to jump in.

## Bonus: act without leaving the chooser

Inside `choose-tree` you can operate on the highlighted item directly:

- `x` — kill the highlighted window or pane
- `f` — filter by a format expression
- `O` — change sort order (index, name, time)
- `t` — tag an item; `x` then acts on all tagged items at once

Tagging plus `x` is the fastest way to clean up a session full of stale windows: tag the dead ones while previewing each, then kill them in a single stroke.
