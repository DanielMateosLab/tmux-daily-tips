# Use send-keys -q to Suppress Command Echoing for Cleaner Automation

When automating commands in tmux using `send-keys`, the pane displays each key press as it's being sent, creating visual noise. The `-q` flag silently injects commands without the character-by-character echo, keeping your pane output clean.

## Command

```bash
send-keys -q -t <target> '<command>' Enter
```

## How It Works

- **`-q`**: Suppresses the command echo, so users see only the command's output, not the keystrokes
- **Without `-q`**: Every character appears in the pane as tmux "types" it, making automation visible but cluttered
- Pairs well with `send-keys -l` for character-by-character input (serial connections) or `-j` to suppress newlines

## Example

Create a key binding that runs a test suite silently:

```bash
bind-key t send-keys -q -t right 'npm test' Enter
```

When you press `Prefix + t`, the command runs without echoing each letter. Compare this to without `-q`, where you'd see `npm test` being "typed" letter by letter in the pane.

For sensitive operations like entering passwords or API tokens via automation, `-q` keeps terminal output clean and uncluttered:

```bash
send-keys -q -t database 'psql -U admin -d mydb' Enter
send-keys -q -t database -l 'SecretPassword123'
send-keys -q -t database 'Enter'
```

Use `-q` when automating repetitive workflows to maintain clean, readable pane output while keeping the speed and precision of programmatic input.
