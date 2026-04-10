

# Use `if-shell` to Create Portable, Adaptive Configs

## The Command

```
if-shell "command -v xclip" \
  "bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -sel clip'" \
  "bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'"
```

## What It Does

`if-shell` runs a shell command and conditionally executes one of two tmux commands based on the exit code. This lets your `tmux.conf` adapt to the current machine — detecting available tools, OS differences, or tmux version features — without maintaining separate config files.

The syntax is:

```
if-shell "shell-test-command" "tmux-cmd-if-true" "tmux-cmd-if-false"
```

The false branch is optional.

## Why It Matters

If you share a single dotfiles repo across macOS and Linux, or across servers with varying tool availability, `if-shell` eliminates the need for symlink tricks or platform-specific config branches. Your tmux config becomes self-adapting.

## Practical Examples

**Detect OS for clipboard integration:**

```tmux
if-shell "uname | grep -q Darwin" \
  "set -g default-command 'reattach-to-user-namespace -l zsh'" \
  ""
```

**Load a plugin file only if it exists:**

```tmux
if-shell "test -f ~/.tmux/statusline.conf" \
  "source-file ~/.tmux/statusline.conf"
```

**Adjust settings based on tmux version:**

```tmux
if-shell '[ "$(tmux -V | cut -d" " -f2 | tr -d "a-z")" = "3.4" ]' \
  "set -g allow-passthrough on" \
  "set -g allow-passthrough off"
```

**Enable true color only if the terminal supports it:**

```tmux
if-shell "test '$COLORTERM' = 'truecolor'" \
  "set -ga terminal-overrides ',*256col*:Tc'"
```

## Tips

- `if-shell` runs **at config load time** by default. Add the `-F` flag to evaluate a tmux format string instead of a shell command.
- Use `-b` to run the shell check in the background (non-blocking).
- You can chain multiple `if-shell` blocks — they execute sequentially during config parse.
