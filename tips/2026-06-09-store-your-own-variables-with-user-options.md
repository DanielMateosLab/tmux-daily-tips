# Store Your Own Variables with `@` User Options

tmux lets you define arbitrary custom options as long as their name starts with `@`. These "user options" are ignored by tmux itself but persist for the session/server and can be read back in formats, scripts, and key bindings — perfect for building stateful configs and toggles without external files.

## Commands

```sh
# Set a user option (server-global with -s, session with nothing, window with -w)
tmux set -g @theme "dark"
tmux set -g @deploy-target "staging"

# Read it back
tmux show -gv @theme          # -> dark

# Use it inside a format
tmux display-message "Target: #{@deploy-target}"
```

## Why it's useful

Plugins like `tmux-resurrect` and `tmux-powerline` rely on `@` options for configuration, but you can use them yourself to remember state between key presses — something a plain shell variable can't do because each pane runs its own shell.

## Concrete example: a persistent toggle

Bind a key that flips a custom flag and acts on it, surviving across panes and windows:

```sh
# In ~/.tmux.conf
bind C-g run-shell '\
  if [ "$(tmux show -gv @gitmode)" = "on" ]; then \
    tmux set -g @gitmode off; \
    tmux display-message "git mode OFF"; \
  else \
    tmux set -g @gitmode on; \
    tmux display-message "git mode ON"; \
  fi'
```

Now `prefix + C-g` toggles `@gitmode`, and any other binding or status-bar format can branch on it:

```sh
# Show the flag in the status bar
set -g status-right "#{?#{==:#{@gitmode},on},#[fg=green]GIT,}"
```

## Inspecting all user options

```sh
tmux show -g | grep '@'        # list every global @ option
tmux set -gu @theme            # -u unsets/removes the option
```

Because they're real tmux options, `@` variables are scoped (server/session/window), survive detach/reattach, and are visible to every pane — making them the idiomatic way to store config and runtime state inside tmux itself.
