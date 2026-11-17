# Find your last pane layout stripped back to its splits

Use `select-layout -o` (the "old" layout) to jump back to whatever arrangement the window had before your last layout change, without the spacing or sizing that the preset layouts impose.

## Command

```
tmux select-layout -o
```

Bind it to a key so you can toggle between two arrangements quickly:

```
bind-key O select-layout -o
```

## Explanation

Each window remembers the layout it had before the most recent layout change. The `-o` flag restores that saved layout. Because tmux stores the layout as a tree of splits, the restored version keeps the same split structure and proportions you had, which makes it a good undo for a `select-layout` preset, a `resize-pane`, or a `main-pane-width` change.

Running `select-layout -o` a second time flips back to the layout you just left, so it behaves like a toggle between two states.

## Example

You have three panes side by side with carefully sized widths, then you run `select-layout tiled` to see everything at once. To get your original arrangement back:

```
tmux select-layout -o
```

Pressing the bound key `prefix + O` again returns you to the tiled view.
