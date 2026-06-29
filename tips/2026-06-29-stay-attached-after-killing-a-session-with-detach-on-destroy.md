# Stay Attached After Killing a Session with detach-on-destroy

When you kill the session you're currently attached to, tmux's default behavior boots you all the way out to your shell — even if you have other sessions running. The `detach-on-destroy` option lets you switch to another session instead of detaching entirely.

## The option

```
set -g detach-on-destroy off
```

Add this to your `~/.tmux.conf`, or set it on the fly:

```
tmux set -g detach-on-destroy off
```

## What it does

By default (`on`), destroying the attached session detaches the client. With `off`, tmux keeps you attached by switching the client to the most recently used remaining session. You only get dropped to the shell when the **last** session is gone.

Newer tmux versions also accept finer-grained values:

- `off` — switch to the previous session
- `no-detached` — only detach if there are no other *detached* sessions
- `previous` / `next` — switch in session order

## Example

Say you have three sessions: `web`, `db`, and `notes`. You're attached to `web` and finished with it:

```
# from inside the "web" session
tmux kill-session
```

With `detach-on-destroy off`, you land directly in `db` (your most recent session) instead of being kicked out to the terminal. Kill that too and you're in `notes`. Only killing the final session returns you to the shell.

## Bonus: clean up everything but the current session

Pair it with `kill-session -a` to nuke all *other* sessions while staying put:

```
tmux kill-session -a
```

This is handy at the end of the day — collapse a sprawl of sessions down to the one you're working in, without ever losing your attachment.
