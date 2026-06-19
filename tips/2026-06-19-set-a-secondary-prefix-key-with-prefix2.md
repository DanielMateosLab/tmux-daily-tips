# Set a Secondary Prefix Key with `prefix2`

The default `C-b` prefix is awkward to reach, and remapping it to something like `C-a` can clash with shell shortcuts (Emacs "beginning of line"). Instead of choosing one, tmux lets you have **two** prefix keys at once via the `prefix2` option. You keep the familiar default while adding a more comfortable alternative.

## The Option

```tmux
# In ~/.tmux.conf
set -g prefix2 C-a
bind C-a send-prefix -2
```

- `set -g prefix2 C-a` registers `C-a` as a second prefix alongside `C-b`.
- The `bind` line ensures that pressing `C-a` twice sends a literal `C-a` to the running program (handy for jumping to line start in your shell), mirroring how `C-b C-b` works for the primary prefix.

Reload with `tmux source-file ~/.tmux.conf` (or `prefix : source-file ~/.tmux.conf`).

## Why It's Useful

- **Zero retraining:** muscle memory for `C-b` still works while you learn `C-a`.
- **Migration aid:** moving from screen (which uses `C-a`)? Set it as `prefix2` and use either binding interchangeably.
- **Per-session flexibility:** because it's a regular option, you can set it on just one session with `-g` omitted from a targeted command.

## Example

After applying the config, every prefix-based command accepts either key:

```text
C-a c      # create a new window (same as C-b c)
C-a "      # split horizontally
C-b %      # still works too
C-a C-a    # sends a literal Ctrl-a to the shell
```

Check what's currently set at any time:

```bash
tmux show-options -g prefix
tmux show-options -g prefix2
```

To disable the secondary prefix later, set it to `None`:

```tmux
set -g prefix2 None
```

This single option gives you the comfort of a custom prefix without giving up the default everyone else's configs and tutorials assume.
