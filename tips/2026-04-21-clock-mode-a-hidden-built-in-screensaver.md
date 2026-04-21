# Clock Mode: A Hidden Built-in Screensaver

Press `prefix + t` to turn any tmux pane into a giant ASCII clock. It's a small novelty, but it's genuinely useful for spotting an idle session across a monitor or grabbing a quick timestamp without running `date`.

## The Shortcut

- `prefix + t` — display the clock in the current pane
- Any key — dismiss the clock and return to the pane

## Customizing the Clock

Clock mode reads a handful of options you can tweak in `~/.tmux.conf`:

```tmux
set -g clock-mode-colour cyan
set -g clock-mode-style 24   # or 12 for AM/PM
```

You can also trigger it from the command line without the keybinding, which is handy inside scripts or when you want to launch it in a specific pane:

```bash
tmux clock-mode -t mysession:0.1
```

## A Concrete Example

Say you run long builds in a dedicated pane and want a clear "idle" indicator when the build finishes. Pair clock mode with a hook so the pane flips to a clock once your build command exits:

```tmux
bind-key B send-keys 'make release && tmux clock-mode' Enter
```

Now `prefix + B` kicks off the build; when it completes, the pane turns into a clock, making it obvious from across the room that the job is done. Pressing any key returns you to the shell prompt with the full build log still in scrollback.

## Why It's Worth Knowing

Clock mode is one of the few tmux features that costs nothing to try and doesn't require memorizing flags. It's a nice first stepping stone for new users exploring the `prefix`-key space, and a lightweight visual cue for power users who juggle many panes.
