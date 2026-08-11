# Quickly Reset a Pane's Terminal State with send-keys -R

**Command:**
```
send-keys -R
```

**Binding:**
```
bind-key C-r send-keys -R
```

## Explanation

The `-R` flag resets a pane's terminal state without clearing the scrollback or visible content. This clears terminal attributes, mode flags, and accumulated formatting glitches—useful when unicode rendering breaks, colors get stuck, or the terminal state becomes corrupted from a crashed process.

Unlike `send-keys clear`, this doesn't clear the screen; it just resets the terminal's internal state.

## Example

Your pane shows garbled characters after running a binary or process that crashed mid-output:

```
Ctrl+B Ctrl+R    # Resets terminal attributes, text becomes readable again
```

Or in a script:
```
tmux send-keys -R -t mywindow:0
```

This is faster and cleaner than killing and respawning a pane when you just need to recover from a formatting issue.
