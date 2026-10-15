# Use `list-keys -N` to Show Only Notes-Annotated Bindings

tmux's `list-keys` normally prints every binding in every key table, which can be a wall of text. Adding `-N` restricts output to bindings that carry a note, and the `-N` flag also works with `bind-key -N` to attach a description to a binding.

## Attaching a note to a binding

When you define a binding, pass `-N` with a description string. The note is stored alongside the binding and does not affect what the key does:

```tmux
bind-key -N "Split horizontally in current directory" '"' split-window -c "#{pane_current_path}"
bind-key -N "Toggle synchronized typing" S setw synchronize-panes
```

## Listing only annotated bindings

Use `list-keys -N` to print just those bindings with their notes:

```sh
tmux list-keys -N
```

Sample output:

```
prefix "  Split horizontally in current directory
prefix S  Toggle synchronized typing
```

This gives you a compact, self-documenting cheat sheet that stays in sync with your config, since the notes live right next to the bindings they describe.

## Practical example

Annotate your most-used custom bindings in `~/.tmux.conf`, then reload:

```tmux
bind-key -N "Reload config" r source-file ~/.tmux.conf \; display-message "Reloaded"
bind-key -N "Pick a session" s choose-tree -Zs
```

```sh
tmux source-file ~/.tmux.conf
tmux list-keys -N
```

Bind `list-keys -N` to a key itself for quick reference:

```tmux
bind-key -N "Show annotated keys" ? list-keys -N
```

Now `prefix ?` shows your personal cheat sheet inside a pane, and any new binding you add with a note appears there automatically.
