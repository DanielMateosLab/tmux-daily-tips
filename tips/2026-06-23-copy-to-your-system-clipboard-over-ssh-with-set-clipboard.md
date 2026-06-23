# Copy to Your System Clipboard Over SSH with `set-clipboard`

Tmux can talk to your terminal's clipboard using the OSC 52 escape sequence, so text you yank in copy mode lands in your **local** system clipboard — even when tmux is running on a remote server over SSH. No `xclip`, `pbcopy`, or shared filesystem required.

## The setting

```tmux
# In ~/.tmux.conf
set -g set-clipboard on
```

- `on` — tmux sets the clipboard *and* accepts clipboard updates from applications.
- `external` — tmux forwards to the terminal but won't store a buffer itself.
- `off` — disable OSC 52 entirely (the old default).

Your terminal emulator must also allow OSC 52 clipboard writes. iTerm2, kitty, WezTerm, Alacritty, and recent xterm all support it (sometimes behind a setting like iTerm2's "Applications in terminal may access clipboard").

## Why it matters

Before OSC 52, copying from a remote tmux meant piping through `xclip` (needs X forwarding) or selecting with the mouse (grabs pane borders and wrapped lines). With `set-clipboard on`, a normal copy-mode yank just *works* across the SSH boundary.

## Example

```bash
# Reload config so the option takes effect
tmux source-file ~/.tmux.conf

# Now, in any pane:
#   1. Prefix + [        enter copy mode
#   2. move to text, press Space, select a region
#   3. Enter (or 'y' in vi mode)
# The selection is now in your laptop's clipboard — paste anywhere with Cmd/Ctrl+V
```

You can also push arbitrary text straight to the clipboard from a script:

```bash
# Send the current git branch to the system clipboard
tmux set-buffer -w "$(git branch --show-current)"
```

The `-w` flag tells `set-buffer` to also write the buffer out via OSC 52, mirroring it to your real clipboard in one step.

## Verify it's active

```bash
tmux show-options -g set-clipboard
# => set-clipboard on
```

If copies still aren't reaching your local clipboard, the bottleneck is almost always the terminal emulator's OSC 52 permission — not tmux.
