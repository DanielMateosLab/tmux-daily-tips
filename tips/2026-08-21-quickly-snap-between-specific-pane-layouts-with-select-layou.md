# Quickly snap between specific pane layouts with select-layout

Switch between your favorite window arrangements instantly using tmux's built-in layout templates.

## Setup

Add to your `.tmux.conf`:

```
bind-key 'v' select-layout even-vertical
bind-key 'h' select-layout even-horizontal
bind-key 't' select-layout tiled
bind-key 'm' select-layout main-horizontal
```

## How it works

- `select-layout` applies a layout template to the current window
- Built-in layouts: `even-vertical`, `even-horizontal`, `tiled`, `main-horizontal`, `main-vertical`
- Each layout resizes panes to fit the template
- Switching layouts preserves panes and their content

## Available layouts

- `even-vertical` — panes side-by-side left-to-right
- `even-horizontal` — panes stacked top-to-bottom
- `tiled` — arrange panes in a grid
- `main-horizontal` — one large pane on top, rest below
- `main-vertical` — one large pane on left, rest on right

## Example

With three panes open, press `Prefix + v` for side-by-side, then `Prefix + m` for main-horizontal. No manual resizing needed.
