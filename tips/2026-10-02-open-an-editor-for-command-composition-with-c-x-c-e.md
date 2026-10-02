# Open an Editor for Command Composition with C-x C-e

## Command

```
send-keys -t pane "C-x" "C-e"
```

## Explanation

The readline shortcut `C-x C-e` opens your `$EDITOR` to compose complex commands before execution. When used with `send-keys`, you can trigger this in a remote pane to edit multi-line scripts or command pipelines using your preferred editor, then execute them automatically after closing the editor.

This is especially useful when automating complex command entry from another pane or session—you compose the command visually in vim/emacs/nano, save, and it runs without manual intervention.

## Example

```tmux
# Stage a complex pipeline in vim from a different pane
tmux send-keys -t work "cat logfile | grep ERROR | awk" "C-x" "C-e"

# Vim opens, you format and add logic, save with :wq, command executes

# Or use it in a script to let users edit automated commands before running
tmux new-window -n edit -c /app
tmux send-keys -t edit "npm run build && npm test" "C-x" "C-e"
# User can now refine the command in their editor before hitting Enter
```

## Pro Tip

Combine this with `set -o vi` (for bash/zsh) to use `ESC v` instead if you prefer vi keybindings, or keep readline defaults with `set -o emacs`.
