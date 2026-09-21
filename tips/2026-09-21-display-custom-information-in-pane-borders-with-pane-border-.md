# Display Custom Information in Pane Borders with pane-border-format

**Command:**
```
set -g pane-border-format "#{pane_index} [#{pane_width}×#{pane_height}]"
```

**What it does:**
The `pane-border-format` option lets you display custom information directly on the pane borders—like pane index, dimensions, or title—without taking up extra space in the status bar.

**Why it's useful:**
When you have many panes or split windows, seeing dimensions or identifiers at a glance saves time. You can quickly verify pane size before resizing, or track which pane is which without relying on the status bar alone.

**Example:**

Add this to your `~/.tmux.conf`:
```
set -g pane-border-status top
set -g pane-border-format "#{pane_index}: #{pane_title}"
```

Or show size and pane number:
```
set -g pane-border-format "[#{pane_index}] #{pane_width}×#{pane_height}"
```

Now when you split panes, you'll see labels like `[0] 80×24` at the top of each border. Set `pane-border-status` to `top`, `bottom`, or `off` to control where labels appear.

**Tip:**
Use format variables like `#{pane_width}`, `#{pane_height}`, `#{pane_index}`, and `#{pane_title}` to customize what's shown. Combine multiple variables for richer information.
