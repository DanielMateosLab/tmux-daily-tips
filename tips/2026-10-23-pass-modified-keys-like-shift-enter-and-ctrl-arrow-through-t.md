# Pass modified keys like Shift+Enter and Ctrl+Arrow through tmux with `extended-keys`

By default, tmux strips modifiers from many keys. Shift+Enter, Ctrl+Arrow, and Ctrl+Shift combinations often arrive as a plain Enter or arrow, so apps running inside tmux can't tell them apart. The `extended-keys` option makes tmux forward these combinations using the CSI u encoding, which modern terminals and apps understand.

## Command

```tmux
set -g extended-keys on
```

Add it to `~/.tmux.conf` and reload with `prefix + r` (or `tmux source-file ~/.tmux.conf`). It takes effect for new key presses immediately.

The three values are:

- `off`: the default in most versions. Modified keys are not forwarded in extended form.
- `on`: forwards extended keys only to applications that request them (for example, by enabling the kitty or xterm modifyOtherKeys protocol).
- `always`: forwards extended keys to every pane, whether or not the application asked for them.

For most setups, `on` is the right choice.

## Make your terminal advertise support

tmux also needs to know that your outer terminal can send extended keys. Add a terminal feature so tmux will use the extended encoding:

```tmux
set -as terminal-features 'xterm*:extkeys'
```

Replace `xterm*` with a pattern that matches your `$TERM` value if you use a different one (for example, `tmux-256color` or `screen*`).

## Example

Suppose you run an editor or AI coding tool in a pane and want Shift+Enter to insert a newline instead of submitting.

1. Add to `~/.tmux.conf`:

   ```tmux
   set -g extended-keys on
   set -as terminal-features 'xterm*:extkeys'
   ```

2. Reload the config:

   ```sh
   tmux source-file ~/.tmux.conf
   ```

3. Open a new pane and check what your key sends. Press Shift+Enter and look at the output of `cat -v` (press Ctrl+C to exit):

   ```sh
   cat -v
   ```

   Without extended keys you see `^M`. With them enabled, you should see an escape sequence such as `^[[13;2u`, which means the app can now detect the Shift modifier.

## Notes

- Requires tmux 3.2 or newer. Check with `tmux -V`.
- Some terminals must also support the extended protocol (kitty, WezTerm, iTerm2, and recent versions of Ghostty and Alacritty do). If the escape sequence doesn't appear, your outer terminal probably isn't sending it.
- If an app's keybindings break after you enable this, set the option back to `off` and reload. `tmux show -g extended-keys` shows the current value.
