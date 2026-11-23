# Hide the window list while keeping the status bar with `status-left-length`

Not a shortcut, but a status-bar trick: `status-left-length` caps how many characters the left side of the status bar may use, so a long session name cannot push the window list off screen.

## The problem

When the session name is long, the left side of the status bar grows and tmux truncates the window list to make room. Setting an explicit limit keeps the window list visible.

## Setting the limit

Run this from the command prompt to apply it to the current session only:

```
:set -t mysession status-left-length 20
```

To make it permanent, add it to `~/.tmux.conf`:

```
set -g status-left-length 20
```

Then reload with `prefix` + `:` and `source-file ~/.tmux.conf`, or run `tmux source-file ~/.tmux.conf` from a shell.

## Example

With a session named `frontend-api-gateway-refactor` and `status-left` set to `[#S] `, the session name fills the left side and pushes the window list to the right edge. Set the limit to 20, and tmux cuts the name at 20 characters, leaving room for every window tab.

Check the current value with:

```
tmux show -gv status-left-length
```
