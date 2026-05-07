# Quickly Switch to a Window by Name with `find-window`

**Shortcut:** `prefix + f`
**Command:** `find-window [-rCNT] match`

When you have a session with many windows, scrolling through them with `prefix + n`/`p` is slow, and even `choose-tree` requires scanning a list. The `find-window` command (bound to `prefix + f` by default) prompts for a search string and jumps directly to the matching window. By default it searches window names, titles, *and* visible pane content, making it powerful for finding "that window where I ran the failing test."

You can refine the search scope with flags:
- `-N` — match only window names
- `-T` — match only window titles
- `-C` — match only visible pane content
- `-r` — treat the match string as a regular expression

If multiple windows match, tmux opens a `choose-tree`-style picker so you can pick the right one.

## Example

Suppose you have ten windows open and one of them is running a `webpack` dev server somewhere. Hit:

```
prefix + f
webpack
```

tmux jumps straight to the window where `webpack` appears in the pane content — no need to remember which window number it was.

For a stricter search that only looks at window names:

```bash
tmux find-window -N "api"
```

Or bind a custom key that searches only visible content (handy for finding error output):

```bash
bind C-f command-prompt -p "search content:" "find-window -C '%%'"
```

Now `prefix + Ctrl-f` prompts you for text and jumps to whichever window currently displays it on screen.
