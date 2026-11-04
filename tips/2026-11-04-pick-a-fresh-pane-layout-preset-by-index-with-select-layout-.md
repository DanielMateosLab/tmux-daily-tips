# Pick a fresh pane layout preset by index with select-layout -t -r

tmux has five built-in layout presets (`even-horizontal`, `even-vertical`, `main-horizontal`, `main-vertical`, `tiled`). Cycling with `next-layout` works, but you can also jump directly to a preset by index. Using `select-layout -t <window> -r`... no, `-r` isn't a flag for this. The reliable way is to name the layout explicitly, or cycle with `next-layout` and inspect the result.

The shortcut is `prefix + Space` for the next preset, but scripting a specific one is clearer with `select-layout`.

## Command

```
tmux select-layout -t <target> <layout-name>
```

Built-in preset names are: `even-horizontal`, `even-vertical`, `main-horizontal`, `main-vertical`, and `tiled`.

## Explanation

`select-layout` applies a named preset to the window you target. Without a name, it reapplies the window's last layout. Because the names are fixed strings, you can bind a key to each preset rather than stepping through them with `prefix + Space`.

Bind a key to a specific preset so you can jump straight to it:

```tmux
bind-key 1 select-layout even-horizontal
bind-key 2 select-layout even-vertical
bind-key 3 select-layout main-vertical
bind-key 4 select-layout tiled
```

Then `prefix + 1` makes the current window's panes side by side, `prefix + 4` tiles them evenly in a grid, and so on.

## Example

Scripted from another terminal, apply a tiled layout to a window with four panes:

```sh
tmux select-layout -t work:2 tiled
```

This changes window `2` of session `work` without switching to it, which is handy when a build script finishes and you want the dashboard tidied up.
