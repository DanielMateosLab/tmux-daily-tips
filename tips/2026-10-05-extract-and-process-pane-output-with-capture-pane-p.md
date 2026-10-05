# Extract and process pane output with capture-pane -p

Pipe pane content directly to shell commands without switching focus, treating tmux as a data source for external scripts.

## Command

```
tmux capture-pane -t <pane> -p | <command>
```

The `-p` flag prints to stdout instead of loading into a buffer, enabling pipeline integration.

## Explanation

`capture-pane -p` reads a pane's scrollback and outputs it to standard output. This lets you integrate tmux panes with external tools: grep for patterns, awk to extract fields, wc to count lines, sort to organize output, or any shell command. Combine with `-S` and `-E` to slice specific line ranges from the pane's history.

## Example

Search for errors across multiple panes:

```bash
for pane in 0 1 2; do
  echo "=== Pane $pane ===="
  tmux capture-pane -t "$pane" -p | grep -i "error"
done
```

Extract timestamps from logs in a pane:

```bash
tmux capture-pane -t 0 -p | grep "^\\[" | tail -5
```

Count log lines in the last 200 lines of history:

```bash
tmux capture-pane -t 1 -p -S -200 | wc -l
```

Save pane output with a date prefix:

```bash
tmux capture-pane -t 0 -p > "output-$(date +%s).txt"
```

Use in cronjobs or scripts to monitor background pane activity without manual attachment.
