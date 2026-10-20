# Show a tmux window's bell and silence flags with `list-windows -F`

The `#{window_bell_flag}` and `#{window_silence_flag}` format variables tell you which background windows rang a bell or went quiet. Pair them with `list-windows` to see every window's alert state in one line, without switching to each window.

## Why it helps

Bell and silence alerts are easy to miss. When a build finishes or a prompt waits for input in a background window, tmux sets a flag on that window, but the flag only shows in the status bar if you have styled it there. Listing the flags from the command line gives you a quick scan of every window in a session, which is useful from a script or a second terminal.

## The command

```
tmux list-windows -F '#{window_index}:#{window_name} bell=#{window_bell_flag} silence=#{window_silence_flag}'
```

Each line shows the window index and name, then `1` or `0` for each flag. A `1` means the window has an unacknowledged alert. The flag clears when you select that window.

## Example

Suppose you run a long build in window 2 and a log tail in window 3 with `monitor-silence` enabled. You can check both from another shell:

```
$ tmux list-windows -F '#{window_index}:#{window_name} bell=#{window_bell_flag} silence=#{window_silence_flag}'
0:editor bell=0 silence=0
1:server bell=0 silence=0
2:build bell=1 silence=0
3:logs bell=0 silence=1
```

Window 2 rang the bell when the build finished, and window 3 went quiet, so its silence flag is set. Select either window to clear its flag.

## Use it in a script

Wait until a build window rings, then continue:

```sh
until [ "$(tmux display -p -t build '#{window_bell_flag}')" = 1 ]; do sleep 2; done
echo "build finished"
```

Replace `build` with the window name or target you use. Make sure `monitor-bell` is on (it is by default) so the bell from the build process sets the flag.
