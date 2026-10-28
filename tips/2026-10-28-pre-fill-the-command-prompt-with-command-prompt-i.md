# Pre-fill the command prompt with `command-prompt -I`

Use `-I` with `command-prompt` to start the prompt with a default value. You edit the default instead of retyping it, and tmux expands format variables in it.

## The syntax

```
command-prompt -I "<default text>" "<command template>"
```

- `-I` sets the initial text. Separate multiple values with commas for multiple prompts.
- `%%` in the template is replaced with what you type. With several prompts, use `%1`, `%2`, and so on.

## Example: rename the current window with its current name filled in

Add this to `~/.tmux.conf`:

```tmux
# Prefix + R opens the prompt with the current window name already filled in
bind R command-prompt -I "#{window_name}" "rename-window -- '%%'"

# Prefix + S does the same for the session name
bind S command-prompt -I "#{session_name}" "rename-session -- '%%'"
```

Press `prefix R`. The prompt shows `api-server`, for example. Press Backspace to trim it, or type over it, then Enter.

Quote `'%%'` in the template. Otherwise a name with spaces or semicolons breaks the command.

## Example: two prompts, one for a name and one for a directory

```tmux
# Prefix + N prompts for a window name and a start directory, both pre-filled
bind N command-prompt -I "scratch,#{pane_current_path}" \
    -p "window name:,start dir:" \
    "new-window -n '%1' -c '%2'"
```

- `-I` gives each prompt a default, separated by a comma.
- `-p` sets the label for each prompt.
- `%1` and `%2` refer to the first and second answers.

Reload with `tmux source-file ~/.tmux.conf` and press `prefix N`. You get a window named `scratch` in the current pane's directory, and you can change either value before pressing Enter.

## Why it helps

Renaming or retargeting a window usually means retyping the old value first. A pre-filled prompt lets you change one word and press Enter.
