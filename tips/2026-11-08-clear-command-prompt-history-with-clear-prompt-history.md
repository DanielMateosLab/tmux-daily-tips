# Clear Command Prompt History with `clear-prompt-history`

The command prompt (`prefix + :`) saves what you type so you can recall it with the up arrow. Sometimes that history holds something you don't want around, such as a path, a token pasted by mistake, or a long run of old commands. `clear-prompt-history` empties it without restarting tmux.

## Usage

From the command prompt:

```
:clear-prompt-history
```

From a shell, against the running server:

```sh
tmux clear-prompt-history
```

To clear only one history, pass `-T` with a type. The types are `command` (the `:` prompt), `search` (the `/` and `?` prompts in copy mode), and `target`.

```sh
tmux clear-prompt-history -T search
```

Check your version first. This command needs tmux 3.4 or newer:

```sh
tmux -V
```

## Example: Bind It to a Key

Add this to `~/.tmux.conf` to clear the command history with `prefix + X`:

```tmux
bind X clear-prompt-history \; display-message "Prompt history cleared"
```

Reload the config with `prefix + r` or `tmux source-file ~/.tmux.conf`, then press `prefix + X` after you've typed something sensitive at the `:` prompt.

## Tip

Pair this with `show-prompt-history` to check what's stored before you wipe it:

```sh
tmux show-prompt-history
```
