# Show a tmux window's last bell count without the status bar

Need to know whether a background window has been bothering you lately? `#{window_bell_flag}` only tells you if a bell is pending, but tmux has no bell counter. Instead, combine `display-message` with `#{window_activity}` style checks to see when a window last received output, then compare it against your own timestamps.

## The shortcut

```
prefix + :
display-message -p "#{window_index}:#{window_name} bell=#{window_bell_flag} silence=#{window_silence_flag} activity=#{window_activity_flag}"
```

Run it from the command prompt and tmux prints the flags for the current window. Add `-t` to target another window without switching to it.

## Why it helps

Activity and bell flags clear as soon as you visit a window, so a quick look at the current state tells you whether anything is waiting. Pairing this with `window_activity` (a Unix timestamp of the last output) lets you see how stale a background window is before you decide to jump in.

## Example

Check window 3 from anywhere without leaving your current pane:

```
tmux display-message -p -t :3 "bell=#{window_bell_flag} last_output=#{window_activity}"
```

Output:

```
bell=1 last_output=1762160400
```

Convert the timestamp with `date -r 1762160400` in a shell to read it as a time. A `bell=1` with an old timestamp means a bell fired and nothing has happened since, so you can probably ignore it. A recent timestamp means the window is still busy.
