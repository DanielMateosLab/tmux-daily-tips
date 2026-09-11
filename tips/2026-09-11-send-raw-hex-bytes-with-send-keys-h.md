# Send Raw Hex Bytes with send-keys -H

Send exact byte sequences to a pane without interpreting them as text, useful for sending control characters that can't be typed normally.

## Command

```
tmux send-keys -t <pane> -H "<hex-bytes>"
```

Hex bytes are space-separated: `1b` (escape), `41` (A), `0d` (carriage return), etc.

## Explanation

`send-keys -H` interprets the argument as hexadecimal byte pairs, bypassing shell interpretation. This bypasses key naming and lets you inject exact byte sequences—critical for sending escape codes, null bytes, or characters your terminal can't produce directly.

Combine with other `send-keys` flags: `-l` for literal text, `-N` to skip history, or multiple hex groups to build sequences.

## Examples

Send an escape sequence (ESC + `[` + `A` for up arrow):
```
tmux send-keys -t . -H "1b 5b 41"
```

Send Ctrl-Z (suspend) via hex:
```
tmux send-keys -t worker -H "1a"
```

Send a null byte to break protocol parsers or inject binary data:
```
tmux send-keys -t test -H "00"
```

Combine hex escape with text to navigate vim:
```
tmux send-keys -t editor -H "1b" "dd"
```

Use `-H` to send a carriage return (0x0D) instead of newline:
```
tmux send-keys -t prompt -H "0d"
```
