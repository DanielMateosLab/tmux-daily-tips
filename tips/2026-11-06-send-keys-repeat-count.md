# Send-Keys Repeat Count

Use `tmux send-keys -N` when you need to send a key multiple times. The `-N` flag is a tmux 3.4+ option that repeats the keys you pass to it, so you don't have to chain them manually.

## Syntax

```
tmux send-keys -N <count> <key>
```

- `-N <count>`: how many times to send the key(s)
- `<key>`: the key name, such as `Left`, `Right`, `BSpace`, or `C-h`

## Why it helps

Interactive tools often need the same keystroke repeated, for example moving a cursor, deleting characters, or stepping through menu items. Scripting that with a loop of separate `send-keys` calls is slower and can race with the application. `-N` sends the whole batch in one command.

## Example

Clear the last 5 characters typed at a shell prompt in another pane:

```
tmux send-keys -t work:1.2 -N 5 BSpace
```

Move the cursor 10 characters to the left in a pane running an editor or readline prompt:

```
tmux send-keys -t work:1.2 -N 10 Left
```

## Tip

Check your version first with `tmux -V`. If you're on an older release, fall back to a shell loop:

```
for i in $(seq 5); do tmux send-keys -t work:1.2 BSpace; done
```
