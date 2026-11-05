# Pick a Tmux Tip: Use `display-popup -E` to Run a Fuzzy Finder for Instant Pane Switching

Pair `display-popup -E` with `fzf` to open a fuzzy finder over every pane across all sessions, then jump to the one you pick.

## The Shortcut

Bind this to a key (for example `prefix + P`):

```
bind P display-popup -E -w 80% -h 60% \
  "tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}  #{window_name}  #{pane_current_command}  #{pane_current_path}' \
   | fzf --reverse --prompt='pane> ' \
   | awk '{print \$1}' \
   | xargs -r tmux switch-client -t"
```

Add it to `~/.tmux.conf` and reload with `prefix + r` (or `tmux source-file ~/.tmux.conf`).

## How It Works

- `list-panes -a` lists every pane on the server, across all sessions and windows.
- `-F` formats each line with the session, window, pane index, window name, running command, and working directory, so you can search by any of them.
- `display-popup -E` runs the pipeline inside a floating popup and closes it when the command exits.
- `fzf` provides the fuzzy filter. Its selection goes to `awk`, which extracts the target address.
- `switch-client -t` jumps your client to that pane. `switch-client` also moves between sessions, so this works across sessions too.

## Example

Press `prefix + P`, then type `vim` and Enter. Your client jumps to the pane whose running command is `vim`, even if it lives in another session.

Requires `fzf` (`brew install fzf`). Without it, the popup closes with an error.
