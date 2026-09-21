# Use send-keys with fzf for Interactive Command Selection in a Pane

When you need to run one of several common commands, fzf can provide a fast, interactive selector directly in your tmux pane.

## Command

```
bind-key C-f send-keys -t . 'fzf <<< "$(echo -e \"deploy\\nrestart\\nlogs\\ntest\\nshell\")"' Enter
```

Or pipe from a history file:

```
send-keys -t pane 'cat ~/.cmd_history | fzf | xargs' Enter
```

## Explanation

`send-keys` can inject shell commands that invoke `fzf` to let you select from a list. The selected item is then either executed or piped to another command. This is useful for frequently-used operations without creating dedicated keybindings for each.

The `-t` flag targets the pane, and wrapping fzf in backticks or a command substitution lets it run in the pane and capture output.

## Example

Create a binding that opens a selector for common git commands:

```
bind-key C-g send-keys -t . 'git $(echo -e \"log --oneline -10\\nstatus\\nbranch -a\\ndiff\" | fzf)' Enter
```

Now `Ctrl+G` brings up an interactive menu. Select with arrow keys, hit Enter, and the command executes immediately. No modal switching needed—stays in the same pane.
