# Create Interactive Prompts with `command-prompt`

## The Command

```
command-prompt [-p "prompt"] "tmux-command '%%'"
```

`command-prompt` opens an interactive input line at the bottom of tmux, waits for your text, and substitutes it into a tmux command. The `%%` token is replaced with whatever you type.

## Why It's Useful

Instead of memorizing exact arguments ahead of time, you can bind keys that **ask you** for input — renaming, targeting, creating sessions — all with a single keystroke followed by freeform text.

## Practical Keybindings

Add these to `~/.tmux.conf`:

```bash
# Prompt to create a new named session
bind C command-prompt -p "New session name:" "new-session -s '%%'"

# Prompt to move the current window to another session
bind M command-prompt -p "Move window to session:" "move-window -t '%%':"

# Prompt to send a command to a target pane (by index)
bind @ command-prompt -p "Pane index:","Command:" "send-keys -t '%1' '%2' Enter"

# Prompt to join a pane from a specific window
bind J command-prompt -p "Join pane from (window.pane):" "join-pane -s '%%'"
```

## Multi-Field Prompts

You can chain multiple prompts with `-p` by separating them with commas. Each input maps to `%1`, `%2`, etc.:

```bash
# Ask for both a host and a port, then SSH
bind S command-prompt -p "Host:","Port:" "new-window -n '%1' 'ssh -p %2 %1'"
```

When triggered, tmux asks for `Host:` first, then `Port:`, and opens a new window running the assembled SSH command.

## Default Values with `-I`

Pre-fill the prompt with a default using `-I`:

```bash
# Rename window, pre-filled with the current name
bind , command-prompt -I "#W" "rename-window '%%'"
```

This is actually how tmux's built-in rename binding works under the hood.

## Example Workflow

1. Press `Prefix` + `C` (with the binding above)
2. Tmux shows: `New session name:`
3. Type `deploy-staging` and hit Enter
4. A new session named `deploy-staging` is created and attached

This turns multi-step operations into quick, guided interactions — no need to drop into the tmux command line with `Prefix` + `:` and type the full command from memory.
