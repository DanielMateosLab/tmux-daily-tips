

# Use `copy-mode` Word and Line Selection Shortcuts

## The Shortcuts

While in copy mode (`prefix + [`), you can select text faster than dragging character by character:

| Action | vi-mode key | emacs-mode key |
|---|---|---|
| Select current word | `Space` then `e` or `w` | `M-h` (Meta-h) |
| Select entire line | `V` (uppercase) | `C-a Space C-e` |
| Jump to matching bracket | `%` | — |

## Why This Matters

Most tmux users enter copy mode and laboriously navigate character by character to select text. Word and line selection shortcuts make grabbing output dramatically faster — especially when copying paths, hashes, or log lines.

## Concrete Example

Say your pane shows a build log:

```
[2026-03-25 14:02:31] Built artifact: /dist/app-3f8a2c1b.js (244 KB)
[2026-03-25 14:02:32] Deployed to staging-cluster-07
```

To copy just the artifact path:

1. `prefix + [` — enter copy mode
2. Navigate to the `/` at the start of the path
3. `v` — begin selection (vi-mode)
4. `E` — jump forward by WORD (stops at the space before `(244`)
5. `Enter` — yank to tmux buffer

To copy the entire line:

1. `prefix + [` — enter copy mode
2. Navigate to the target line
3. `V` — select the full line instantly
4. `Enter` — yank

## Bonus: Select and Paste in One Flow

Combine with `prefix + ]` to paste immediately into another pane:

```bash
# Copy a git SHA from log output, then paste it into another pane
# 1. prefix + [     (enter copy mode in the log pane)
# 2. b              (jump back to start of the SHA word)
# 3. v e            (select the word)
# 4. Enter          (yank it)
# 5. select target pane
# 6. prefix + ]     (paste)
```

## Pro Tip: Append to Buffer

Use `A` (uppercase) instead of `Enter` to **append** to the existing paste buffer rather than replacing it. This lets you collect multiple words or lines from different places before pasting them all at once.
