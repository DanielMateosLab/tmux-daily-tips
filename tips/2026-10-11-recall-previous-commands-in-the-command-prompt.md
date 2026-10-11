# Recall previous commands in the command prompt

Press `prefix :` to open the command prompt, then use `Up` and `Down` to cycle through commands you ran there earlier. Tmux keeps this history on the server, so it survives closing and reopening the prompt. You don't need to retype long commands like `new-window -c "#{pane_current_path}"` or a complex `send-keys` line.

## Inspecting and clearing the history

From a shell in any pane, you can list the stored history:

```sh
tmux show-prompt-history
```

To wipe it, for example before a screen share or after testing something you don't want to repeat:

```sh
tmux clear-prompt-history
```

Both commands are available in tmux 3.2 and later. Run `tmux -V` to check your version.

## Example workflow

1. Press `prefix :` and type `new-window -c "#{pane_current_path}" -n logs`, then press Enter.
2. Later, press `prefix :` and press `Up` once. The same command appears, ready to edit or run.
3. To change one part, move the cursor with the arrow keys, edit the text, and press Enter. The edited version is added as a new history entry.

Use this to repeat layout or session setup commands without rebuilding them each time. Pair it with `command-prompt -I` in your config if you want a key that opens the prompt pre-filled with a template.
