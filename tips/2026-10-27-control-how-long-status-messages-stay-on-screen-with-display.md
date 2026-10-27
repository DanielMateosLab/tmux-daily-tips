# Control How Long Status Messages Stay On Screen with `display-time`

tmux shows transient messages in the status bar for things like `display-message`, `command-prompt` errors, and `choose-buffer` feedback. By default they vanish after about 750 ms, which can be too quick to read. The `display-time` option sets how long they stay, in milliseconds.

## The Option

```
set-option -g display-time <milliseconds>
```

Use `-g` for all sessions. Omit it to apply the setting to the current session only.

## Explanation

Messages that are easy to miss include:

- Errors from a failed `source-file` or a bad key binding
- Output from `display-message -p`-style checks you run interactively
- Confirmations after `set-buffer`, `save-buffer`, or `rename-window`

Raising `display-time` gives you time to read them. Set it to `0` to keep the message until your next keypress. Lower values keep the status bar cleaner.

To pick a value for a single moment, run it from the command prompt with `prefix :` and then type the command. The change applies immediately, so you can adjust it without editing your config.

## Example

Add this to `~/.tmux.conf` to keep messages on screen for three seconds:

```
# Keep status messages visible for 3 seconds
set-option -g display-time 3000
```

Then reload the config:

```
tmux source-file ~/.tmux.conf
```

Now run a command that produces a message, such as renaming a window with `prefix ,`. The confirmation stays in the status bar for three seconds before it clears.

For errors you want to read in full, set a longer delay only while you work on the config, then reset it to the default.
