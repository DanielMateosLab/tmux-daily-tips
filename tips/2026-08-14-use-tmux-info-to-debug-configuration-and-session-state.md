# Use tmux info to debug configuration and session state

**Command**: `tmux info`

Displays detailed server, session, window, and pane configuration along with all option values and format variables. Perfect for verifying settings took effect, understanding state, and diagnosing why something isn't working as expected.

## Quick inspection

Run from any tmux client to see all active sessions, every option at every scope (server, session, window, pane), and current pane and window details.

## Example: verify a setting took effect

```
$ tmux set-option -g history-limit 50000
$ tmux info | grep history_limit
```

## Example: find conflicting keybindings

```
$ tmux info | grep binding
```

View all keybindings to spot conflicts or identify why a custom binding isn't responding.

## Pro tip: pipe to less for interactive search

```
$ tmux info | less
```

Press `/` to search interactively for any option name, making troubleshooting faster than piping to grep.
