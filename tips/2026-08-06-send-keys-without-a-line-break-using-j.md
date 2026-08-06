# Send Keys Without a Line Break Using -J

## Command

```tmux
send-keys -J 'text'
```

## Explanation

The `-J` flag sends keystrokes without a trailing newline, leaving text on the prompt line for the user to complete or modify before pressing Enter.

This is useful for injecting command prefixes, paths, or partial input that you want the user to finish typing.

## Example

Bind a key to insert a search prefix without executing:

```tmux
bind C-g send-keys -J 'grep -r "'
```

Now `Ctrl-G` types `grep -r "` and waits for you to finish typing the search term and close the quote.

Another example—navigate to a project directory without running the command:

```tmux
bind M-p send-keys -J 'cd ~/projects/'
```

Pressing `Alt-P` types the path, lets you tab-complete a subfolder name, then you press Enter to navigate.

## Comparison

```tmux
# Without -J (executes immediately after typing)
send-keys 'echo done'

# With -J (text stays on prompt, doesn't execute)
send-keys -J 'echo '
```

Use `-J` when you want the pane to stay in edit mode after the keys are sent.
