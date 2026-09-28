# Slow Down send-keys for Serial Connections

When sending commands to a pane connected to a slow device (serial terminal, embedded system, slow SSH), rapid character delivery can overwhelm the input buffer or cause dropped characters.

## The trick

Use `send-keys` with a shell function that adds delays between characters:

```tmux
bind-key S send-keys -l "printf 'command' | while IFS= read -r -n1 char; do printf '%s' \"\$char\"; sleep 0.05; done" Enter
```

Or create a helper function in your shell:

```bash
slowtype() {
  while IFS= read -r -n1 char; do
    printf '%s' "$char"
    sleep "${1:-.05}"
  done <<< "$2"
}
```

Then in tmux:

```tmux
send-keys -l "slowtype 0.1 'my-long-command-here'" Enter
```

## Why it matters

Serial terminals and embedded devices often have limited input buffers. Dumping text too fast causes `Buffer I/O error` or silent character loss. Adding 50ms–100ms pauses between characters gives slow devices time to process.

## Example

For an Arduino or Raspberry Pi over serial (baud rate 9600):

```tmux
bind-key A send-keys -l "printf 'AT+CWJAP=\"ssid\",\"password\"\\r\\n' | while IFS= read -r -n1 c; do printf '%s' \"$c\"; sleep 0.15; done"
```

Adjust the sleep duration based on device responsiveness—start at 0.1s and dial down if it works faster.
