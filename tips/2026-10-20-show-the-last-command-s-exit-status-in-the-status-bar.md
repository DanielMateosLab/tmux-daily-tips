# Show the Last Command's Exit Status in the Status Bar

tmux does not show whether the last command in a pane succeeded. You can surface that with a format conditional on `pane_dead_status` only for dead panes, but for live shells the usual approach is to have the shell write its exit status into a pane option, then read it from the status line.

## Setup

Add this to your shell's prompt hook (zsh shown here) so every prompt updates a pane-local option:

```zsh
precmd() {
  [[ -n "$TMUX" ]] && tmux set-option -pq @last_status "$?"
}
```

Then reference the option in your `~/.tmux.conf`:

```tmux
set -g status-right '#{?#{==:#{@last_status},0},#[fg=green]ok,#[fg=red]exit #{@last_status}} #[default]%H:%M'
```

## How it works

- `set-option -p` writes a pane-scoped user option (the `@` prefix marks it as a user option).
- `-q` suppresses errors if the option is not yet set.
- `#{?cond,a,b}` is a conditional format: it shows `ok` in green when the last exit was `0`, and the numeric code in red otherwise.
- The status line refreshes on its normal interval, so the indicator updates within a few seconds of a command finishing.

## Example

```zsh
$ false
```

The status bar now shows `exit 1` in red on the right side. Running `true` flips it back to a green `ok`.

## Notes

- The status line displays the value of the **currently active pane**, so switching panes updates the indicator to that pane's status.
- If you use a shell other than zsh, use the equivalent prompt hook (for bash, `PROMPT_COMMAND`).
