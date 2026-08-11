# Preserve ANSI Colors When Capturing Pane Output

**Command:**
```
tmux capture-pane -p -e -t pane
tmux capture-pane -p -e -t pane -S -50  # Last 50 lines
```

**Explanation:**
By default, `capture-pane -p` strips ANSI escape codes (colors, bold, underline, etc.) from pane output. Add the `-e` flag to preserve them. This is essential when copying styled terminal output—colored logs, grep results, or git diff output—into external tools or documents that support ANSI styling.

**Example:**
Your pane shows colorized JSON with `jq`:
```
tmux capture-pane -p -e -t 1
```

The output retains all colors and formatting when you paste it elsewhere. Without `-e`, the output loses all styling and appears monochrome. Pair this with `-S` and `-E` to extract specific line ranges while keeping their formatting intact.
