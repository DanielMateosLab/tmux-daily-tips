# Eliminate the ESC Key Delay with escape-time

By default tmux waits a fraction of a second after you press `Esc` to see whether it's the start of an escape sequence (like an arrow key). Inside Vim, Neovim, or any modal program this shows up as a sluggish, laggy `Esc` that makes switching out of insert mode feel broken.

## The fix

Set the `escape-time` option to a low value (or zero) in your `~/.tmux.conf`:

```
# Make Esc instant — great for Vim/Neovim users
set -sg escape-time 0
```

The `-s` flag sets it as a **server option**, so it applies to every session. Reload your config and the lag is gone:

```
tmux source-file ~/.tmux.conf
```

## Why not always zero?

Over a flaky or high-latency SSH connection, a value of `0` can occasionally cause real escape sequences to be split, producing stray characters. If you work over remote links, a small buffer is safer than zero:

```
set -sg escape-time 10   # 10 milliseconds — still imperceptible, more robust
```

## Verify the current value

Check what your server is actually using:

```
tmux show-options -s escape-time
# => escape-time 0
```

## Example workflow

1. Open Vim inside tmux and enter insert mode with `i`.
2. Type some text, then hit `Esc`.
3. With the default 500 ms delay, the cursor seems stuck in insert mode for a beat.
4. After setting `escape-time 0`, `Esc` returns you to normal mode instantly — Vim feels native again.

This is one of the highest-impact, lowest-effort lines you can add to a tmux config, especially for anyone living in a modal editor all day.
