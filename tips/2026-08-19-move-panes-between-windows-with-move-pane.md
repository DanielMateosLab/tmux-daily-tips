# Move panes between windows with move-pane

`tmux move-pane` lets you relocate an entire pane from one window to another, reorganizing your layout without closing and recreating panes.

## Shortcut

```
tmux move-pane -s <source> -t <destination>
```

## Usage

Move the current pane to another window:

```
tmux move-pane -t mywindow
```

Move a specific pane to a specific window:

```
tmux move-pane -s mysession:window.1 -t mysession:otherwindow
```

Swap panes between windows by moving one, then moving another back:

```
tmux move-pane -s dev:0.0 -t build
tmux move-pane -s build.0 -t dev:0
```

## Practical Example

You're working in window `code` with three panes. Your test runner is in pane 1, but you want to consolidate it into window `tests`:

```
tmux move-pane -s code.1 -t tests
```

The pane migrates completely—no respawning, no lost scrollback. Useful when you need to reorganize after discovering which panes should work together, or when consolidating related work into one window.
