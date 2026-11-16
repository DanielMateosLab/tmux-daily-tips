# Stop copy-mode search from wrapping around

**Command:** `setw -g wrap-search off`

By default, copy-mode search wraps. Pressing `n` past the last match jumps back to the top of the scrollback, so you can miss that you've run out of matches. Turning wrapping off makes the search stop at the first and last match instead.

Add this to `~/.tmux.conf`:

```tmux
setw -g wrap-search off
```

Then reload the config with `prefix + r`, or run `tmux source-file ~/.tmux.conf` from a shell.

## Example

Suppose a build log has three `ERROR` lines and you're reading upward from the bottom:

1. Enter copy mode with `prefix + [`.
2. Type `/ERROR` and press Enter. tmux jumps to the nearest match above the cursor.
3. Press `n` to step upward through the matches. After the top match, `n` stops there instead of cycling back to the bottom.
4. Press `N` to reverse direction. The same edge rule applies.

With wrapping on, step 3 would jump from the top match back to the bottom and keep going, which makes it easy to lose your place in a long log.

To change this for one window, run `setw wrap-search off` while that window is active. Omit `-g` to set it only for the current window.
