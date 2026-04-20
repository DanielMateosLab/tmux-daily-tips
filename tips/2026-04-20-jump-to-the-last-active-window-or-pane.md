# Jump to the Last Active Window or Pane

Tmux remembers where you just came from. Use `prefix + l` to toggle back to the previously active window, and `prefix + ;` to toggle back to the previously active pane — no cycling, no counting, just instant flip-flop between two contexts.

## The Shortcuts

- `prefix + l` — switch to the last active **window** (lowercase L)
- `prefix + ;` — switch to the last active **pane**

Both are built-in defaults, no config required. They behave like `cd -` in a shell: press once to jump, press again to come back.

## Why It's Useful

Most real work bounces between two things: code and logs, editor and shell, server and client. Instead of hunting with `prefix + n/p` or the window list, you train your fingers on a single toggle. It's faster than numeric window selection once you have more than a couple windows open.

## Example

You're editing in window 2 and tailing logs in window 5:

```
# In window 2 (editor), press:
prefix + l
# → instantly jumps to window 5 (logs)

prefix + l
# → back to window 2
```

Same idea for panes within a window — say you have an editor pane and a test-runner pane side by side:

```
prefix + ;
# → jumps to the other pane
```

## Optional: Rebind for Faster Access

If you find yourself using this constantly, drop the prefix entirely with a custom binding in `~/.tmux.conf`:

```tmux
bind-key -n M-l last-window
bind-key -n M-\; last-pane
```

Now `Alt+l` toggles windows and `Alt+;` toggles panes with no prefix at all. Reload with `prefix + :` then `source-file ~/.tmux.conf`.

## Bonus: Combine With Marked Panes

`last-pane` only remembers one step back. If you need a *persistent* bookmark, pair it with `prefix + m` (mark a pane) and `select-pane -t '{marker}'` for a fixed target, while keeping `prefix + ;` for the volatile toggle. Two separate muscle memories, two separate jobs.
