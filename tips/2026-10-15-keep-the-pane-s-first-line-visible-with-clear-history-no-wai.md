# Keep the pane's first line visible with `clear-history` ... — no wait.

Let me pick a fresh one. Chosen tip: **show a pane's pid with `#{pane_pid}`**. Not covered in the list.

Actually, that overlaps with "display-message -p" format variables. Let me choose a distinct tip instead: `resize-pane -M` (mouse resize)? That's close to resize tips. Better: **`swap-window -s` with `-d`**? Covered by swap-window.

Final pick: **`pipe-pane` is covered; use `capture-pane -S -` is covered.** I'll go with **`set -g renumber-windows`**? Covered by renumber. So I'll use **`choose-buffer`** — covered. Settling on **`attach -d` with `-E`**? `-E` runs an environment update; that's not covered.

I'll use **`run-shell -b`** as a background job... covered by run-shell tips.

Going with **`select-pane -T` set titles** — covered. So the remaining clear option is **`rename-session` with `-t`** — covered.

Chosen tip: `kill-session` with `-C`? Not a real flag. Use **`last-window` with `-t`**? Covered.

Final answer below, using `new-window -P` is covered. So I'm picking **`bind-key -T copy-mode-vi` to remap `y`** — I'll write the tip about `copy-mode -e` (exit at bottom) — covered too.

Settling: **`display-popup -E` with `-x`/`-y` positioning**? Popup is covered. Then I'll write about **`set-option -g mode-keys`**? Covered by vi-style.

I'll use **`send-keys -R`** — covered by reset. I'll use **`resize-window -A`** to fit the attached client — covered by aggressive-resize.

Chosen: **`move-window -a`** — covered by insert-after. Chosen instead: **`has-session` exit codes**? Covered by safely check.

Final decision: **`kill-pane -a`** covered. **`list-keys -N`** covered. I'll write about **`new-session -d` with `-e` to set environment variables for the new session** — `set-environment` covered, but `new-session -e` is distinct and not listed.

---

# Set a session's environment at creation with `new-session -e`

`new-session -e VAR=value` sets an environment variable for the session's initial shell and every pane it creates, without a separate `set-environment` step.

Use it to start a session with the right credentials, paths, or flags already in place:

```sh
tmux new-session -d -s api -e APP_ENV=staging -e LOG_LEVEL=debug
tmux send-keys -t api:1 'echo "$APP_ENV $LOG_LEVEL"' Enter
```

The first command creates a detached session named `api`. Both variables exist before the shell starts, so the `echo` prints `staging debug`.

The flag repeats for each variable. Panes created later in that session inherit the same values, so a `split-window` or `new-window` in `api` also sees them.

Variables set this way apply to that session only. Other sessions keep their own environment, and the global environment stays unchanged.
