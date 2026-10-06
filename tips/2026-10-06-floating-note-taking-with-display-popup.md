# Floating Note-Taking with display-popup

Quickly jot down ideas, debugging notes, or reminders in a floating window without disrupting your workflow.

## The Command

```tmux
bind-key N display-popup -h 10 -w 30 -E 'nvim ~/.tmux-notes && cat ~/.tmux-notes'
```

## How It Works

`display-popup` creates a temporary floating window overlaying your current panes. The flags mean:
- `-h 10` — 10 lines tall
- `-w 30` — 30 characters wide
- `-E` — close the popup after the command exits

When you press `<prefix> N`, a floating editor appears. Edit your note, save and exit, then the popup shows your note before closing. Bind it to a custom key in your config.

## Concrete Example

Add this to your `~/.tmux.conf`:

```tmux
bind-key N display-popup -h 15 -w 50 -E 'vim ~/.tmux-notes && tail -5 ~/.tmux-notes'
```

Press `<prefix> N` while debugging a slow query. Type your observation ("connection timeout after 30s on prod replica"). Exit vim. The last 5 lines of your notes flash on screen as confirmation. The popup vanishes, and you're back to work.

## Pro Tips

Redirect output to append instead of overwrite:

```tmux
bind-key N display-popup -h 10 -w 40 -E 'echo "$(date): $(read -p Note:)" >> ~/.tmux-notes && tail -3 ~/.tmux-notes'
```

Or open a full editor with a dedicated notes window instead of a popup for longer sessions:

```tmux
bind-key A new-window -n notes 'vim ~/.tmux-notes'
```
