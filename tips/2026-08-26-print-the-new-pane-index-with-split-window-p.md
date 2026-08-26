# Print the new pane index with split-window -P

Use the `-P` flag with `split-window` to print the new pane's ID to stdout immediately. This lets you capture and operate on a newly created pane in scripts without counting or parsing.

## The command

```
split-window -h -P
```

Prints the pane ID (e.g., `%.2`) so you can reference it right away.

## Example

```bash
# Create a split and capture its pane ID
pane=$(tmux split-window -v -P -t mywindow -c /tmp)
tmux send-keys -t "$pane" 'npm start' Enter
```

The `-P` flag works with any split direction (`-h`, `-v`), percentage sizing (`-p 30`), background mode (`-b`), or working directory (`-c`). It's especially useful when automating pane creation in scripts—no need to parse output or calculate indices.
