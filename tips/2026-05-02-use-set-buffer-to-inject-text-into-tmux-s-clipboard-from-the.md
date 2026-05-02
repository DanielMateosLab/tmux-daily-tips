# Use `set-buffer` to Inject Text into tmux's Clipboard from the Shell

## The Command

```bash
tmux set-buffer "text to paste later"
tmux paste-buffer        # paste into the current pane
```

## What It Does

`set-buffer` lets you push arbitrary text from the shell (or a script) directly into a tmux paste buffer, without ever entering copy mode. Combined with `paste-buffer` (default prefix binding `]`), this turns tmux into a programmable clipboard that any pane or window can pull from.

This is incredibly handy when you want to:

- Pre-load a long command, password, or token from a script and paste it into a REPL
- Move output from one tool into another without touching the system clipboard
- Build shell aliases that "stage" text for the next paste

## Concrete Example

Say you have a long kubectl command you want to send into a fresh shell pane:

```bash
# Stage the command from outside tmux (or from any pane)
tmux set-buffer "kubectl logs -f deploy/api -n production --since=1h | grep ERROR"

# Now switch to the target pane and hit:  prefix + ]
# The command appears at the prompt, ready to edit or run.
```

Pull the contents of a file straight into a buffer:

```bash
tmux set-buffer -b notes "$(cat ~/snippets/aws-debug.sh)"
tmux paste-buffer -b notes -t mywindow.1
```

The `-b` flag names the buffer so you can keep several around and pick one with `prefix + =` (choose-buffer). Pair it with `set-buffer -a` to *append* to an existing buffer instead of replacing it — perfect for accumulating snippets across panes before pasting them as a single block.

## Bonus: One-liner From a Pipe

```bash
echo "deploy-token-abc123" | tmux load-buffer -
```

`load-buffer -` reads stdin into the buffer, so any command's output can be queued for the next paste.
