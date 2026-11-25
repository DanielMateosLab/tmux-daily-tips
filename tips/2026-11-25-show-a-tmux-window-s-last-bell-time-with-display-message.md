# Show a tmux window's last-bell time with display-message

Reading `window_bell_flag` tells you a window rang, but not when. To pull the time, you need a format variable that stores it, or a hook that writes it down. tmux doesn't expose a `window_bell_time` variable, so the reliable method is a bell hook that stamps a user option, then a format that reads it back.

## Stamp the time on every bell

Add this to `~/.tmux.conf`:

```tmux
set-hook -g alert-bell 'set-window-option -t "#{hook_window}" @last_bell "#{t:client_activity}"'
```

`alert-bell` fires once per bell, with `hook_window` set to the window that rang. The `@last_bell` option is a window-scoped user option, so it survives until the next bell overwrites it.

## Read it back

Run this in the command prompt or bind it to a key:

```tmux
display-message -p "#{@last_bell}"
```

Inside a specific window, target it with `-t`:

```tmux
display-message -p -t :2 "#{@last_bell}"
```

If the option is empty, that window has not rung since the hook was installed.

## Show it in the status bar

Add the stamp next to the window name so you can see when a background job last rang:

```tmux
set -g window-status-format '#I:#W #{?@last_bell,[bell #{@last_bell}],}'
```

The `#{?...}` conditional prints the bell time only when the option is set, so quiet windows stay clean.

Use `#{t:client_activity}` rather than `#{t:window_bell_flag}` because `window_bell_flag` is `0` or `1`, not a timestamp. The `t:` modifier formats a Unix timestamp, and `client_activity` already holds one.
