# Show a pane's TTY device path with display-message

Every pane runs on a pseudo-terminal, and tmux exposes its device path through the `pane_tty` format variable. Use it when a script, debugger, or logger needs to write directly to a pane's terminal.

## The command

```sh
tmux display-message -p '#{pane_tty}'
```

Run it inside a pane to print that pane's TTY, such as `/dev/ttys012`. The `-p` flag prints the result to stdout instead of the status bar.

## Why it helps

Some tools accept a TTY path as an argument, and writing to that device shows output in the pane without running a command there. Logging to a pane works this way, and so does handing a pane's terminal to a debugger.

## Example

Send a message straight into another pane's terminal, bypassing its shell:

```sh
target=$(tmux display-message -p -t 2 '#{pane_tty}')
echo "build finished" > "$target"
```

The `-t 2` flag targets pane 2 in the current window. The text appears in that pane's output, and the shell there never sees it as input.

## Caveat

Writing to a TTY you do not own can corrupt the other program's screen, so use this for output only, and only on panes you control.
