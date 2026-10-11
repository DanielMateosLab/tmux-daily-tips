# Recall Your Last Command in the Command Prompt with Up Arrow

Press `prefix + :` to open the command prompt, then use the **Up** and **Down** arrow keys to step through previously entered commands. Commands are stored in a history that persists for the life of the tmux server, so you can reuse a long `new-window` or `send-keys` invocation without retyping it.

## Why it helps

The command prompt is easy to forget about, but it keeps its own history separate from your shell's. Anything you ran through `:` (for example `split-window -h -c "#{pane_current_path}"`) can be recalled and tweaked without leaving tmux.

## Example

Run a split with a specific size and directory:

```
prefix + :
split-window -h -l 40% -c "#{pane_current_path}"
```

Later, to make the same split in a different layout, press `prefix + :`, press **Up** to bring back the previous command, edit `40%` to `30%`, and hit **Enter**.

You can also type a partial command and press **Up** to search only history entries that start with what you typed, which works like a quick filter.
