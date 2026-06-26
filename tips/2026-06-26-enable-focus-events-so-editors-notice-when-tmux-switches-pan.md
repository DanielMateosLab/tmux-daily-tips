# Enable focus-events So Editors Notice When tmux Switches Panes

```tmux
set -g focus-events on
```

By default, tmux doesn't tell programs running inside a pane when that pane gains or loses focus. That breaks a surprising number of features: Vim/Neovim's `autoread` won't reload files changed on disk, plugins like `vim-gitgutter` won't refresh, and any app relying on terminal focus reporting (`FocusGained`/`FocusLost` escape sequences) sits blind.

Turning on `focus-events` makes tmux forward the terminal's focus in/out reports to the active pane — but **only if your outer terminal supports and emits them** (most modern ones do: iTerm2, kitty, Alacritty, WezTerm, GNOME Terminal).

## Why it matters

Without focus events, this common Vim setting silently does nothing inside tmux:

```vim
" Reload the file if it changed on disk when the window regains focus
set autoread
autocmd FocusGained,BufEnter * checktime
```

With `focus-events on`, switching back to the pane fires `FocusGained`, Vim runs `checktime`, and your buffer updates to match the file your build tool or `git pull` just rewrote.

## Example

Add it to `~/.tmux.conf`:

```tmux
set -g focus-events on
```

Reload without restarting:

```bash
tmux source-file ~/.tmux.conf
```

Now test it. Open a file in Vim in one pane, edit and save the same file from another pane (or shell), then switch focus back to the Vim pane:

```bash
# Pane B — change the file Vim has open in Pane A
echo "updated from another pane" >> notes.txt
```

The moment you select the Vim pane again, the buffer refreshes automatically — no manual `:e` required.

## Quick check

Confirm the option is live:

```bash
tmux show -g focus-events
# focus-events on
```

If editors still don't react, the bottleneck is your outer terminal — verify it has focus reporting enabled in its settings.
