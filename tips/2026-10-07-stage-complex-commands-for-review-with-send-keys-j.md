# Stage Complex Commands for Review With send-keys -J

When building commands programmatically in tmux, it's often useful to assemble a multi-part pipeline in a pane without executing it, so you can review the syntax before letting it run. Use `send-keys -J` (no newline) to append text without advancing, then send the final part with Enter.

**Command:**
```
tmux send-keys -J -t <pane> "<text>" ""
```

Repeat with `-J` for each chunk, then send the final part with "Enter" to execute.

**Example:**

Build a complex grep pipeline interactively:

```bash
tmux send-keys -J -t work "tail -100 app.log | " ""
tmux send-keys -J -t work "grep -E 'ERROR|WARN' | " ""
tmux send-keys -J -t work "cut -d: -f1-3 | " ""
tmux send-keys -t work "sort | uniq -c" "Enter"
```

The pane displays the complete command on one line before execution. You can review it, edit with arrow keys and backspace, or Ctrl+C to cancel if the syntax looks wrong.

**Why:** Building commands in visible stages lets you verify complex pipelines before they run—especially useful for remote sessions or one-shot data processing scripts where typos are costly. Beats rebuilding the same 50-character command five times.
