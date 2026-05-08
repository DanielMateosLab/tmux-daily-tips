# Jump Between Panes by Direction History with `last-pane`-Style Stacks

**Command:** `select-pane -t '{last}'` and bound key `prefix + ;`

While `prefix + ;` toggles between the current and previously focused pane, you can extend this with `select-pane -l` (lowercase L) inside scripts and key bindings to build a richer "back/forward" navigation flow across panes — without relying on directional keys.

## How it works

- `prefix + ;` — switch to the last active pane (built-in default).
- `select-pane -l` — same effect, scriptable form for use in `bind-key` or `run-shell`.
- Combine with `display-message` to confirm the jump, useful when panes look similar.

## Example: a "bounce" key that pings between two panes and flashes the title

Add to `~/.tmux.conf`:

```tmux
bind-key b run-shell "tmux select-pane -l; tmux display-message 'Bounced to #P: #T'"
```

Now `prefix + b` toggles to the last pane and shows its index and title in the status bar:

```
Bounced to 2: build-watcher
```

## Why it's useful

When you're alternating between, say, an editor pane and a test runner pane, `prefix + b` gives you a one-key bounce with visual confirmation — faster than `prefix + arrow` navigation and immune to layout changes, since "last pane" is tracked by focus history, not position.

Pair it with `set -g display-time 1000` so the confirmation message lingers just long enough to read without getting in the way.
