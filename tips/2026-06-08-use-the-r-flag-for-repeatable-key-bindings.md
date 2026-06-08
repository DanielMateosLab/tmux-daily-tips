# Use the `-r` Flag for Repeatable Key Bindings

When you bind a key with `bind-key -r`, tmux lets you press the bound key **repeatedly** without re-typing the prefix each time, as long as you stay within the `repeat-time` window (500ms by default). This is perfect for resizing panes or stepping through windows.

## The shortcut

Add `-r` to any `bind-key` in your `~/.tmux.conf`:

```tmux
# Resize panes by holding prefix once, then tapping H/J/K/L
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Step through windows without re-pressing prefix
bind -r n next-window
bind -r p previous-window
```

## Why it helps

Normally every action needs `prefix` + key. With `-r`, you press `prefix` **once**, then mash the key as many times as you like. Tmux keeps the "repeat table" active until you pause longer than `repeat-time`, so a burst of taps all count.

## Tune the window

The default 500ms can feel rushed. Widen it so slower taps still chain:

```tmux
set -g repeat-time 700
```

## Concrete example

With the bindings above, to shrink a pane by 25 columns from the left:

```
C-b H H H H H
```

One prefix, five quick `H` taps — the pane shrinks 5 columns each press. Pause, and the next key needs the prefix again.

## Check which keys are repeatable

`list-keys` marks repeatable bindings, or filter directly:

```bash
tmux list-keys | grep -- '-r'
```

Use `-r` for any incremental, "do it again" action; leave it off for one-shot commands like `kill-pane` where an accidental repeat would hurt.
