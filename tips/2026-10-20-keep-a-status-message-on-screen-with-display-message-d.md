# Keep a Status Message on Screen with display-message -d

`display-message` shows a message in the status bar for a short time, 750 ms by default. The `-d` flag sets the duration for one message in milliseconds. Use `-d 0` to keep the message visible until you press a key.

## Command

```
tmux display-message -d 0 "message text"
```

## Explanation

- `-d <ms>` overrides the `display-time` option for that message only.
- `-d 0` keeps the message on screen until the next keypress clears it.
- Use `set -g display-time 3000` if you want a longer default for every message.

## Example: Announce a finished job from a script

Long-running scripts often finish while you are looking at another window. A persistent message makes sure you see the result when you return:

```
./deploy.sh; tmux display-message -d 0 "Deploy exited with status $?"
```

## Example: Bind a key to show context on demand

Add this to `~/.tmux.conf` to show the current pane's path and session name until you dismiss it:

```
bind-key P display-message -d 0 "#{session_name} | #{pane_current_path}"
```

Press `prefix` then `P`, read the message, and press any key to clear it.

## Tip

Set `-d` only when a message needs attention. Persistent messages can hide the status bar contents you rely on, so keep the default duration for routine notices.
