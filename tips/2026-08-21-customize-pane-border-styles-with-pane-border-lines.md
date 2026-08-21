# Customize pane border styles with pane-border-lines

**Shortcut/Command:** `set -g pane-border-lines double|single|heavy|rounded`

**Explanation:**
The `pane-border-lines` option controls the visual style of the lines drawn between panes. Instead of plain ASCII characters, you can use box-drawing characters to make your layout more visually distinct and easier to parse at a glance.

Supported styles:
- `single`: Standard single-line box characters
- `double`: Double-line box characters for prominence
- `heavy`: Thick line characters
- `simple`: Basic ASCII `-` and `|`
- `rounded`: Box characters with rounded corners

**Example:**

Add this to your `.tmux.conf`:

```
set -g pane-border-lines rounded
set -g pane-border-style fg=colour8
set -g pane-active-border-style fg=colour4,bold
```

Now split panes and the borders will render as rounded boxes, with inactive borders in gray and the active pane border in bold blue.

Switch styles on the fly:

```
tmux set -g pane-border-lines double
```

This pairs nicely with `pane-border-status top` to add a title bar to each pane border, giving you a fully customized grid layout.
