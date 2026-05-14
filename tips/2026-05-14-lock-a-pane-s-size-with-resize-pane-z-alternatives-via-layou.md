# Lock a Pane's Size with `resize-pane -Z` Alternatives via Layout Manipulation

**Command:** `tmux set-window-option main-pane-width <cells>` and `select-layout main-vertical`

The `main-vertical` and `main-horizontal` layouts reserve one "main" pane at a fixed size while the rest tile alongside it. Unlike manual resizing (which gets reset whenever you split or kill a pane), the `main-pane-width` and `main-pane-height` options *persist* through layout changes — perfect for keeping a primary editor pane at exactly the size you want while sub-panes (logs, REPLs, tests) rearrange themselves.

## How it works

- `main-pane-width N` — width in cells for the main pane in `main-vertical` layout
- `main-pane-height N` — height in cells for the main pane in `main-horizontal` layout
- Apply with `select-layout main-vertical` (or `main-horizontal`)
- Re-applying the layout after splits keeps the main pane at the locked size

## Example

Set up an editor on the left at exactly 120 columns, with everything else stacked on the right:

```sh
tmux set-window-option main-pane-width 120
tmux select-layout main-vertical
```

Now split off as many helper panes as you like — they'll share the right side while your editor stays at 120 columns:

```sh
tmux split-window -h          # opens on the right side
tmux split-window -v          # stacks another below it
tmux select-layout main-vertical   # re-tile; main pane snaps back to 120
```

## Bind it for one-key re-tiling

Add to `~/.tmux.conf` so you can restore the locked layout anytime after rearranging:

```tmux
bind M set-window-option main-pane-width 120 \; select-layout main-vertical
bind H set-window-option main-pane-height 30 \; select-layout main-horizontal
```

Press `prefix + M` and the editor pane snaps back to 120 columns wide — no matter how many panes you've added or removed.

## Why this beats manual resizing

Manual `resize-pane` adjustments evaporate the moment you split, kill, or break out a pane. The `main-*` options are declarative: tmux re-derives the geometry every time the layout is applied, so your "primary workspace" stays predictable across a chaotic session.
