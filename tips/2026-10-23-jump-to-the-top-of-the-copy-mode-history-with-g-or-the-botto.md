# Jump to the top of the copy-mode history with `g`, or the bottom with `G`

In copy mode, `g` moves the cursor to the first line of scrollback and `G` moves it to the last line. These work in vi mode, which the list in `2026-06-27` already covers, but the case here is narrower: you want the whole history at once, not a word or a line.

## Command

```
prefix [
g    # top of scrollback
G    # bottom of scrollback
```

In emacs copy mode (the default), use `M-<` for the top and `M->` for the bottom.

## Explanation

Scrolling with the mouse or `PageUp` works, but on a pane with a long history you can spend many keypresses reaching the oldest output. `g` jumps straight to the top, and `G` returns you to the live prompt without leaving copy mode first. Once you are at the top, you can search with `/` or `?` from that point.

## Example

A build fails hours into a long-running pane and the error is near the start of the log:

```
prefix [          # enter copy mode
g                 # jump to the oldest line
/error            # search forward from there
n                 # step to the next match
G                 # return to the live output and exit by pressing q
```
