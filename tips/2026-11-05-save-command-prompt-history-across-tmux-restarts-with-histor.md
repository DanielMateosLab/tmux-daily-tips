# Save command prompt history across tmux restarts with `history-file`

**Option:** `history-file` (tmux 3.4 and later)

Every command you type at the `:` prompt, and every search you run from it, is kept in memory for the life of the server. Set `history-file` and tmux writes that history to disk when the server exits and reloads it on startup, so pressing Up at the command prompt still recalls commands from yesterday.

## Explanation

The command prompt keeps a history per prompt type: commands, search strings, and so on. Without `history-file`, that history disappears when the tmux server stops. Setting the option to a path makes tmux persist the history there. The path supports `~` expansion.

Put it in your config file:

```tmux
set -g history-file ~/.tmux_history
```

Then reload the config with `prefix` + `:` and `source-file ~/.tmux.conf`, or restart the server. Newly entered commands are written to the file, so the history survives `tmux kill-server` and reboots.

## Example

Suppose you often run the same layout command at the prompt:

```
prefix + :
select-layout -E
```

After adding `history-file` and restarting the server, open the prompt again with `prefix` + `:`, press Up, and the `select-layout -E` line comes back. You can also press Up on any earlier command, or type a prefix and press Up to filter by it.

To keep the history per server instead of shared, use a socket-specific path:

```tmux
set -g history-file "~/.tmux/history-#{socket_name}"
```

Check that the option took effect with:

```sh
tmux show-options -g history-file
```
