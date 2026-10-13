# Share a tmux pane's zoom state and layout in one view with `break-pane -d`

Pull a pane into its own window without switching to it, so a background process keeps running while you watch it from another window.

Most people reach for `break-pane` to split a pane out, but it switches focus to the new window by default. Adding `-d` keeps you where you are.

## The command

```
tmux break-pane -d -t <pane>
```

`-d` stops tmux from making the new window active. `-t` names the pane to move.

## Example

You have a long-running build in the bottom pane of a window and want it isolated, while you keep editing in the top pane:

```
tmux break-pane -d -t bottom
```

The build moves into a new window, and your cursor stays on the editor pane. Switch to the new window later with `prefix + n` or `prefix + w` when you want to check the output.

Bind it to a key so the move takes one keystroke:

```
bind-key B break-pane -d
```

With that binding, `prefix + B` pushes the active pane into its own window and leaves focus where it was.
