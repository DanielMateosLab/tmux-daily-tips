# Tmux Tip: Reload a Pane's Scrollback Without Clearing the Screen

Most tmux users clear a pane with `Ctrl-L` or `clear`, which wipes what's visible. To check whether the scrollback still holds output from before that clear, you need a different approach.

## Shortcut

`prefix` + `:` then `capture-pane -p -S -`

Or from the shell:

```sh
tmux capture-pane -p -S - -t <pane>
```

## Explanation

`capture-pane -p` prints the pane's contents to stdout. The `-S -` flag starts from the very beginning of the scrollback history instead of only the visible screen. Combined with `-p`, the output goes straight to your terminal, so you can read it without saving a file.

This is useful when you cleared the screen by mistake, or when you need to see output that has scrolled far up. It doesn't change the pane, and it doesn't depend on copy mode.

## Example

Suppose a build ran earlier in a pane and you cleared it:

```sh
# In the pane you cleared:
clear

# In any other pane, view everything the pane has kept:
tmux capture-pane -p -S - -t 2 | less
```

To grab only the last 200 lines of history instead of all of it:

```sh
tmux capture-pane -p -S -200 -t 2 | tail -n 50
```

`-S -200` starts 200 lines back from the bottom of the visible area, which is handy for quick inspection without paging through everything.

## Tip

Pair this with `less` so the output scrolls on your terminal rather than flooding the pane you're working in. The `history-limit` option controls how much scrollback is kept, so raise it if older output is being discarded before you need it.
