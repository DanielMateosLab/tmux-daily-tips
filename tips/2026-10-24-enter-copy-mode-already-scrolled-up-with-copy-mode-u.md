# Enter Copy Mode Already Scrolled Up with `copy-mode -u`

Pressing the prefix and `[` enters copy mode at the bottom of the pane, so the first thing you need to do is scroll up. `copy-mode -u` enters copy mode and scrolls up one page immediately, so the most recent screenful of history is already on screen.

## Usage

From the command prompt (`prefix :`) or a shell:

```
tmux copy-mode -u
```

Combine it with `-e` to get the bottom-exit behavior as well. Scrolling back down to the bottom then leaves copy mode automatically.

## Bind it to a key

Add a root-table binding to `~/.tmux.conf` so `PageUp` works without the prefix:

```
bind -n PageUp copy-mode -eu
```

Reload the config:

```
tmux source-file ~/.tmux.conf
```

## Example

1. Run a command that prints a lot of output, such as `seq 1 500`.
2. Press `PageUp` in the pane. Copy mode opens with the previous page already visible.
3. Keep pressing `PageUp` to move further back, or press `q` to return to the live prompt.
4. Scroll back down to the bottom and copy mode exits by itself, because of `-e`.

## Why it helps

- It saves a keypress or two compared with entering copy mode and then paging up.
- Binding it without the prefix makes history browsing feel like a normal terminal scrollbar.
- Using `-e` means you never end up stuck in copy mode after you have finished reading.
