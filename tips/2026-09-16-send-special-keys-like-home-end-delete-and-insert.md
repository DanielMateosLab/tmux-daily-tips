# Send Special Keys Like Home, End, Delete, and Insert

**Command:**
```
tmux send-keys -t PANE KEY_NAME
```

**Explanation:**
You can send any named key directly to a pane without typing it manually. tmux recognizes standard terminal key names like `Home`, `End`, `Delete`, `Insert`, `BackSpace`, plus function keys `F1` through `F12`. This is useful for scripting interactions with terminal applications like editors, REPLs, and CLI tools.

**Examples:**

Jump to end of line and delete characters:
```
tmux send-keys -t 0 End
tmux send-keys -t 0 C-d C-d C-d
```

Clear a command and insert a new one:
```
tmux send-keys -t mywin Home C-k "new command" Enter
```

Trigger a function key for an app (e.g., F5 in Vim to refresh):
```
tmux send-keys -t editor F5
```

Navigate in `less` with Page Down:
```
tmux send-keys -t logs Page_Down
```

**Available keys:** `Home`, `End`, `Page_Up`, `Page_Down`, `Insert`, `Delete`, `BackSpace`, `Tab`, `Escape`, `F1`–`F12`, arrow keys (`Up`, `Down`, `Left`, `Right`), and any literal character.
