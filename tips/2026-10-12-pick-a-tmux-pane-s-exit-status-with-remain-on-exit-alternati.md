# Pick a tmux pane's exit status with `remain-on-exit` alternatives... 

Wait, that topic is already covered. Here is a fresh one.

# Join a Command's Output into a Named Buffer with `capture-pane -b`

Stop reading a pane into your clipboard and use a named buffer. The `-b` flag on `capture-pane` writes the captured text into a buffer with the name you choose, so scripts can pick it up later without touching the default buffer stack.

```sh
tmux capture-pane -p -t build -S -200
```

That prints the output. Add `-b` to store it instead:

```sh
tmux capture-pane -b last-build -t build -S -200
```

The text lands in the buffer `last-build`. The default buffer stays untouched, so an earlier copy-mode yank survives. Read it back with:

```sh
tmux show-buffer -b last-build
```

Or paste it into the current pane:

```sh
tmux paste-buffer -b last-build -p
```

The `-p` flag sends bracketed-paste markers, which keeps multi-line text from executing line by line in shells that support it.

## Example: keep a failing test's output for later

A test watcher runs in pane `tests`. When you want the last 300 lines saved under a name you can reuse, run this from any pane:

```sh
tmux capture-pane -b failing-tests -t tests -S -300
tmux save-buffer -b failing-tests ~/logs/failing-tests.txt
```

Each new capture overwrites the named buffer, so reusing the same name always holds the latest snapshot. Use `tmux list-buffers` to confirm it exists.
