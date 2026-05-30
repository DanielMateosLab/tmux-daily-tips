# Switch Between Sessions Without Detaching

Jump straight from one session to another while staying attached, using the built-in session-switching keys.

## The shortcut

- `prefix + (` — switch to the **previous** session
- `prefix + )` — switch to the **next** session
- `prefix + L` — toggle back to the **last** session you were in

These run the `switch-client` command under the hood:

```
tmux switch-client -p   # previous session
tmux switch-client -n   # next session
tmux switch-client -l   # last (most recent) session
```

## Why it's useful

Most people detach (`prefix + d`) and re-attach to move between sessions, or open `choose-tree`. But if you keep a handful of long-lived sessions (say `work`, `notes`, `logs`), `switch-client` lets you flip through them like browser tabs — no detach, no menu, no typing names.

The `-l` flag is the real gem: it remembers your previous session, so `prefix + L` becomes a fast toggle between the two sessions you bounce between most.

## Example

You're in session `work` and want to check something in `logs`:

```
prefix + )        # cycle forward until you land on "logs"
```

Read what you needed, then snap right back:

```
prefix + L        # instantly returns to "work"
```

## Jump to a session by name

If you know exactly where you want to go, target it directly from any pane:

```
tmux switch-client -t notes
```

Bind it for one-key access in `~/.tmux.conf`:

```
bind N switch-client -t notes
bind W switch-client -t work
```

Now `prefix + N` and `prefix + W` teleport you to those sessions regardless of which window or pane you're in.

## Tip

Combine `-l` with a single key for an even faster toggle:

```
bind Space switch-client -l
```

`prefix + Space` now ping-pongs between your two latest sessions — perfect for a code/test or editor/logs split across separate sessions.
