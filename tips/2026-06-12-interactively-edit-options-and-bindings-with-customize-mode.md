# Interactively Edit Options and Bindings with Customize Mode

`<prefix> C` opens **customize mode** — a browsable, tree-style menu of every tmux option, key binding, and color setting that you can change live and even save to your config.

## The Shortcut

```
<prefix> C        # capital C — opens customize-mode
```

Or run it manually:

```bash
tmux customize-mode
```

## Why It's Useful

Most people edit `~/.tmux.conf`, reload, and squint at what changed. Customize mode lets you explore the *entire* option space — server, session, window, and pane scopes — with each setting's current value and built-in description shown inline. No more grepping the man page to remember whether it's `status-style` or `status-bg`.

Changes apply instantly so you can preview them, and you can persist the ones you like without leaving tmux.

## Navigation Keys

| Key | Action |
|-----|--------|
| `↑`/`↓` or `j`/`k` | Move between entries |
| `Enter` / `→` | Expand a section or edit a value |
| `s` | Set/change the selected option's value |
| `S` | Set it and append the change to your config file |
| `u` | Unset (revert to default) |
| `/` | Search for an option by name |
| `q` | Quit customize mode |

## Concrete Example

Say you want to turn on the mouse and check what `status-keys` is set to:

1. Press `<prefix> C`.
2. Press `/`, type `mouse`, hit `Enter`.
3. Highlight `mouse`, press `s`, type `on`, press `Enter` — scrolling and pane selection now work immediately.
4. Press `S` instead if you want tmux to write `set -g mouse on` to your config for next time.
5. Press `/` again, search `status-keys`, and read its current value (`emacs` or `vi`) right there.

Treat it as a discoverable settings panel: browse the `Keys` section to see every binding in context, or the `Server`/`Session`/`Window` trees to audit your whole setup without touching a single file.
