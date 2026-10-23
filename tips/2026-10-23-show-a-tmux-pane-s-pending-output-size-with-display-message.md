# Show a tmux pane's pending-output size with `display-message`

Pick a pane and ask tmux how far its scrollback has grown relative to its visible height. This is useful in scripts that need to know whether a pane has produced output beyond what's on screen before deciding to capture or page it.

## The command

```sh
tmux display-message -p -t <target> '#{history_size}'
```

`#{history_size}` is the number of lines currently stored in the pane's scrollback buffer. Combined with `#{pane_height}`, it tells you whether anything has scrolled off-screen.

## Why it helps

Capturing a pane is expensive if you do it blindly. Checking the history size first lets a script skip the capture when nothing has scrolled, and only pull lines that actually exist.

## Example

Capture only when the pane has scrolled past its visible area:

```sh
#!/usr/bin/env zsh
target="${1:-%1}"

history=$(tmux display-message -p -t "$target" '#{history_size}')
height=$(tmux display-message -p -t "$target" '#{pane_height}')

if (( history > 0 )); then
  echo "Pane $target has $history lines of scrollback (visible height: $height)"
  tmux capture-pane -p -t "$target" -S -"$history"
else
  echo "Pane $target has not scrolled yet; nothing to capture."
fi
```

Run it with `./check-scrollback.sh %3` to report and dump the scrollback of pane `%3`. Because `-S -<history>` starts the capture at the oldest stored line, the output includes everything that has ever scrolled off.

## Tip

Pair this with `#{pane_height}` to decide whether to page the output: if `history_size` is small relative to the terminal height, a plain `capture-pane` is cheap enough; if it's large, pipe the result into `less` instead of printing it all to the terminal.
