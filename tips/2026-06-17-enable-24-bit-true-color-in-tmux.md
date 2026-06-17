# Enable 24-bit True Color in tmux

By default tmux can flatten the rich color palettes used by modern editors and prompts down to 256 colors, leaving Neovim themes, `bat`, and `delta` looking washed out. Telling tmux that your terminal supports RGB fixes it.

## The command

On tmux 3.2 and newer, add this to `~/.tmux.conf`:

```tmux
# Tell tmux its own $TERM is 256-color capable...
set -g default-terminal "tmux-256color"

# ...and that the OUTER terminal supports true color (RGB)
set -as terminal-features ",xterm-256color:RGB"
```

The `-as` flags **a**ppend to the existing **s**et, so you can list several terminal types without clobbering each other.

## How it works

`terminal-features` declares capabilities for a given outer `$TERM`. The `RGB` flag tells tmux the terminal accepts 24-bit `SGR` color escapes, so it passes them straight through instead of quantizing to 256. The pattern before the colon (`xterm-256color`) is matched against the terminal you launched tmux *from* — check it with `echo $TERM` outside tmux and adjust if yours differs (e.g. `alacritty`, `screen-256color`).

On older tmux (pre-3.2), use the legacy override syntax instead:

```tmux
set -ga terminal-overrides ",xterm-256color:Tc"
```

## Verify it

Reload your config, then run this inside tmux — you should see a smooth gradient, not banded blocks:

```sh
tmux source-file ~/.tmux.conf

awk 'BEGIN{
  for (i=0;i<256;i++){
    r=(i<85)?i*3:((i<170)?(255-(i-85)*3):0)
    printf "\033[48;2;%d;0;%dm ", r, 255-r
  }
  print "\033[0m"
}'
```

You can also confirm tmux advertises RGB to programs:

```sh
tmux info | grep -i RGB
```

If your editor still looks dull, make sure the app itself opts in too — for example, `set termguicolors` in Neovim.
