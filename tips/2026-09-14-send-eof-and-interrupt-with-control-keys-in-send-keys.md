# Send EOF and Interrupt with Control Keys in send-keys

**Command:**
```
tmux send-keys -t <pane> C-d
```

**Explanation:**
Send Ctrl+D (EOF) or Ctrl+C (interrupt) to a pane programmatically. Ctrl+D signals end-of-file to close shells or interactive prompts; Ctrl+C interrupts running commands. Use these with target-specific sends to control processes without switching panes.

**Examples:**

Interrupt a long-running command in another pane:
```
tmux send-keys -t build:0 C-c
```

Close a shell or Python REPL without typing `exit`:
```
tmux send-keys -t repl:0 C-d
```

Stop a hung process and try again:
```
tmux send-keys -t worker:0 C-c
tmux send-keys -t worker:0 "make build" Enter
```

Chain multiple interrupts with recovery:
```
tmux send-keys -t test:0 C-c C-c C-d
```

**Common patterns:**
- `C-c` — terminate foreground process (SIGINT)
- `C-d` — send EOF to close session or pipe
- `C-c C-c` — double-interrupt for stubborn processes
- `C-d C-d` — redundant EOF, closes more reliably

Combine with `run-shell` to automate cleanup workflows after detecting process hangs.
