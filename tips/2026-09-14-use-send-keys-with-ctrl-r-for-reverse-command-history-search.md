# Use send-keys with Ctrl+R for reverse command history search in remote panes

## Shortcut
```
tmux send-keys -t session:window.pane 'C-r'
```

## Explanation
When you need to re-run a previous command in a remote pane without switching focus there, send `C-r` (Ctrl+R) via send-keys to trigger your shell's reverse history search. This works with bash, zsh, and other shells using readline. You can chain searches by sending partial command strings followed by the search key, making it fast to find and re-execute commands programmatically.

## Example
Monitor a build in one pane while re-running tests in another:

```sh
# Send Ctrl+R to start reverse search in the test pane
tmux send-keys -t dev:main.1 'C-r'

# Send search term without triggering yet
tmux send-keys -t dev:main.1 'npm test' 'L-'

# Wait for user to confirm or manually type more
# User hits Enter to re-run the matched command
```

Or automate a repeated debugging workflow:

```sh
# Re-run the last make command from any pane
tmux send-keys -t build:compile.0 'C-r' 'make' 'Enter'
```

This keeps focus where you need it while navigating history in background panes. Works especially well for long-running processes where you want to test fixes in one pane without leaving another.
