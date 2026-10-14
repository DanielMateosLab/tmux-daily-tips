# Paste Multi-Line Text Safely with `paste-buffer -p`

By default, `paste-buffer` sends each newline as a carriage return, so a shell or REPL runs every line as soon as it arrives. The `-p` flag wraps the paste in bracketed paste sequences. Applications that support bracketed paste (zsh, bash with readline, vim, Python REPL, and most modern editors) then treat the whole block as one paste and don't execute it line by line.

## Usage

```
tmux paste-buffer -p -t {target-pane}
```

Bind it to a key so you can paste from the prompt:

```
bind P paste-buffer -p
```

Press `prefix` + `P` to paste the most recent buffer.

## Example

Suppose you have a multi-line snippet in a buffer:

```sh
tmux set-buffer "for f in *.log; do
  echo \"== \$f ==\"
  tail -n 3 \"\$f\"
done"
```

Pasting it normally runs each line as it arrives, which can break loops and leave partial commands behind. With `-p`, the shell receives the block as one paste and waits for you to press Enter:

```sh
tmux paste-buffer -p -t work:0.1
```

Add `-d` to delete the buffer after pasting, which is useful for one-off snippets:

```sh
tmux paste-buffer -p -d -t work:0.1
```

## Notes

- `-p` only has an effect if the target application has enabled bracketed paste mode. If it hasn't, tmux falls back to a normal paste.
- Use `-r` if you need the newlines left as plain LF instead of converted to CR.
- Check your buffers with `tmux list-buffers` before pasting.
