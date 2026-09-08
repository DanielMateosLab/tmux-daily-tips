# Search pane output for patterns with capture-pane and grep

Extract and search through any pane's visible output without switching focus, even from command-line scripts and CI/CD pipelines.

## The shortcut

```bash
tmux capture-pane -t session:window.pane -p | grep "pattern"
```

- `-t` specifies the pane target
- `-p` prints to stdout
- Pipe the output to `grep` (or `sed`, `awk`, etc.) to filter

## Why it's useful

You can audit pane output, parse logs, or find errors without disrupting your workflow. This works remotely over SSH, in scripts, or as part of automation—no switching panes required.

## Concrete example

Search for errors in a background build pane:

```bash
tmux capture-pane -t build:0.1 -p | grep -i "error\|warning\|fail"
```

Extract the last compile time from a pane:

```bash
tmux capture-pane -t build:0.0 -p | grep "Compiled in" | tail -1
```

Bind a key to show errors in the current pane in a popup:

```bash
bind-key e display-popup -h 50% -w 80% "tmux capture-pane -t #{pane_id} -p | grep -i error || echo 'No errors found'"
```

## Extended use

Combine with `-S` to limit lines captured:

```bash
tmux capture-pane -t session:window.pane -p -S -50 | grep "pattern"
```

Use `-J` to preserve word-wrap boundaries if you're parsing wrapped text:

```bash
tmux capture-pane -t session:window.pane -p -J | grep "pattern"
```
