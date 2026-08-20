# Navigate panes by direction without knowing pane numbers

Use `select-pane` with directional flags (`-R`, `-L`, `-U`, `-D`) to jump between adjacent panes by their position. This beats pane numbers because it works regardless of how panes are split.

**Command:**
```
tmux select-pane -<direction>
```

Directions: `L` (left), `R` (right), `U` (up), `D` (down)

**Keybinding example:**

```
bind -r H select-pane -L
bind -r J select-pane -D
bind -r K select-pane -U
bind -r L select-pane -R
```

Press `Prefix` + `H/J/K/L` to navigate. The `-r` flag makes bindings repeatable—hold the keys to navigate rapidly.

**Example:**

Move focus to the pane on the right:
```
tmux select-pane -R
```

Or switch to the pane above:
```
tmux select-pane -U
```

**Why it matters:**

Directional navigation is intuitive and adapts automatically to your layout. Once you bind these keys, pane movement becomes muscle memory instead of requiring you to toggle pane numbers with `display-panes` first.
