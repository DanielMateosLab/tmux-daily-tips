# Show the cursor position of a pane with `display-message`

Need to know where the cursor sits inside a pane, for example before sending keys that depend on the column? tmux exposes it through format variables, so one `display-message` call reports it without touching the pane.

Run this from any pane:

```
tmux display-message -p -t %3 "cursor at x=#{cursor_x} y=#{cursor_y}"
```

The `-p` flag prints the result to stdout instead of the status bar, so scripts can capture it. `-t %3` targets pane 3 by its ID. The `#{cursor_x}` and `#{cursor_y}` variables give the zero-based column and row of the cursor inside that pane.

Combine it with `capture-pane` to read the text on the line the cursor is on:

```
row=$(tmux display-message -p -t %3 '#{cursor_y}')
tmux capture-pane -p -t %3 -S "$row" -E "$row"
```

This prints the current line of the pane, which helps when a script needs to decide whether a prompt is waiting for input or a command is still running.

Other useful variables include `#{pane_width}`, `#{pane_height}`, and `#{alternate_on}`, which reports whether the pane is in a full-screen application such as `vim` or `less`.
