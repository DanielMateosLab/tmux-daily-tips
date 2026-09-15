# Stage Commands in a Pane Without Executing Them

`send-keys` **without pressing Enter** to compose commands for review before execution

## Shortcut

```tmux
send-keys -t PANE-ID "your command here"
```

The key: omit the `Enter` (no `M-Enter` or `C-m`). The command text appears in the shell prompt, ready for you to review or edit before pressing Enter yourself.

## Why It's Useful

Sometimes you want to construct a complex command in a remote pane or automated workflow, but you don't trust it blindly—or you want to let someone review it first before it runs. Staging the command on the prompt line lets you (or an observer) see exactly what will execute.

## Examples

Prepare a destructive command in a pane for manual review:

```tmux
send-keys -t dev:1 "rm -rf ./tmp-cache/ && echo 'cache cleared'"
```

The command sits on the prompt. You can review it in the pane, tweak it with readline keys, then hit Enter.

Build a multi-step workflow where each step waits for approval:

```tmux
send-keys -t deploy:0 "git push origin main"    # stage first command
# ... human review happens ...
# Then manually press Enter in that pane to execute
send-keys -t deploy:0 "C-m"                     # now execute it
```

For SSH sessions, stage a command so the remote operator can review before running:

```tmux
send-keys -t remote:0 "sudo systemctl restart myapp"
```

The shell waits. No surprise execution.

## Combine with Other Flags

Use `-l` (literal) if your command has shell metacharacters you don't want interpreted:

```tmux
send-keys -l -t work:2 'echo $HOME/*.log'  # won't expand $HOME or glob
```

Human reviews it, then they can tweak or hit Enter.
