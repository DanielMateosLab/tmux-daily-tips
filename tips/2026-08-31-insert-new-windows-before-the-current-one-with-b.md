# Insert new windows before the current one with -b

Use the `-b` flag with `new-window` to insert a window **before** the current position instead of after it. Useful for keeping related windows grouped without disrupting your current workflow.

## Shortcut
```
Ctrl-b :new-window -b -n name
```

Or bind it:
```
bind-key -n M-N new-window -b
```

## Explanation
By default, `new-window` (or `new-window -a`) appends the window after the current one, pushing your window index up. The `-b` flag reverses this, inserting the new window immediately before the active window. This keeps your focused window at the same index while organizing related windows before it.

Combine `-b` with `-d` to create a window without switching to it, or `-c` to set its working directory.

## Examples

Insert a new scratch window before the current one:
```
tmux new-window -b -n scratch -c ~/tmp
```

Bind a key to quickly insert a log-monitoring window before your main work:
```
bind-key -n M-l new-window -b -n logs -c /var/log
```

List your windows to confirm placement:
```
tmux list-windows
```
