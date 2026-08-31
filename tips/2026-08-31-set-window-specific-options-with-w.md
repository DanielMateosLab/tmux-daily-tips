# Set Window-Specific Options with -w

**Command:** `set-option -w [option] [value]` or `setw` (shorthand)

Configure individual windows with their own settings, independent of session or server defaults. Use `-t window` to target a specific window.

```tmux
setw -t mywindow aggressive-resize on
set-window-option -w pane-border-status top
```

**Example:** Aggressive-resize on for your dev window, off everywhere else:

```tmux
set-option -w aggressive-resize off        # default for all new windows
setw -t dev aggressive-resize on           # override just this window
```

Now the dev window keeps panes evenly sized when you resize, while other windows don't.

**Common options to override per-window:** automatic-rename, aggressive-resize, pane-border-status, synchronize-panes, monitor-activity, monitor-silence, main-pane-height, main-pane-width.
