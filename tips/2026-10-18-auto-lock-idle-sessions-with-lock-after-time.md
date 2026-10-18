# Auto-lock Idle Sessions with `lock-after-time`

tmux can lock a session automatically after a period of inactivity, so an unattended terminal can't be used by someone walking past it. This is the built-in version of manually locking with `lock-session`.

## The option

```tmux
set -g lock-after-time 300
```

The value is the number of seconds without keyboard input before the session locks. `0` (the default) disables the feature.

## How it works

- When a client has been idle for `lock-after-time` seconds, tmux runs `lock-command` on that client's terminal.
- The default `lock-command` is `lock -np`, which uses the system's screen locker (`lock` on BSD, `vlock` on Linux when available). It asks for the current user's password to unlock.
- Any keypress in the terminal counts as activity and resets the timer.

To use a different locker, set `lock-command` yourself:

```tmux
set -g lock-after-time 600
set -g lock-command "vlock"
```

## Example

Add this to `~/.tmux.conf` to lock after 10 minutes of inactivity:

```tmux
# Lock the terminal after 10 minutes idle
set -g lock-after-time 600
```

Reload the configuration:

```sh
tmux source-file ~/.tmux.conf
```

Then leave the terminal untouched for 10 minutes. The client shows the lock prompt, and you unlock it with your password. Set `lock-after-time` back to `0` to turn the feature off.
