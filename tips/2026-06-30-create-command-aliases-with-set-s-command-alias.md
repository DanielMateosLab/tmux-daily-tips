# Create Command Aliases with `set -s command-alias`

tmux lets you define your own short names for long commands, just like the built-in aliases (`splitw`, `neww`, etc.). Add an entry to the server-level `command-alias` array and you can invoke a complex command by typing a single word at the command prompt.

## The option

```tmux
set -s command-alias[100] "alias-name=full command here"
```

`command-alias` is a **server option** (`-s`), so it applies globally. tmux ships with default aliases at low indices, so use a high index like `100` to avoid clobbering them.

## Why it's useful

Once defined, your alias works everywhere a tmux command is accepted: the command prompt (`prefix + :`), key bindings, the CLI (`tmux alias-name`), and config files. It turns a frequently-typed incantation into something memorable.

## Concrete example

Add these to your `~/.tmux.conf`:

```tmux
# Pop open a log tail in a side pane
set -s command-alias[100] "logs=split-window -h 'tail -f /var/log/syslog'"

# Reload config in one word
set -s command-alias[101] "reload=source-file ~/.tmux.conf"

# Lay out three even vertical panes
set -s command-alias[102] "tri=select-layout even-horizontal"
```

Reload, then at the command prompt (`prefix + :`) type:

```
:logs
```

A new pane splits off tailing your syslog. Type `:reload` to re-read your config, or `:tri` to rearrange panes — no need to remember the full command each time.

## Inspecting existing aliases

See everything that's currently defined, including the built-ins:

```bash
tmux show-options -s command-alias
```

This prints each index and its mapping, which is handy for picking a free slot and for learning the canonical short forms tmux already provides.

## Tip

Aliases are plain text substitutions of the **command name only** — arguments you type after the alias are appended. So `:logs` could be designed to take a filename if you write the alias to expect one, but for fixed workflows, baking the whole command in (as above) is the simplest and most reliable approach.
