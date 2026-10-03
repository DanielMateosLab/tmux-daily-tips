# Safely Batch-Kill Sessions by Pattern with Confirmation

Kill multiple sessions matching a name pattern while confirming each one before destruction.

## The One-Liner

```bash
tmux list-sessions -f '#{session_name}' | grep PATTERN | while read s; do
  tmux confirm-before -p "Kill $s?" "kill-session -t $s"
done
```

## Add a Keybinding

```tmux
bind-key -n M-K command-prompt -p 'Sessions matching:' \
  'run-shell "tmux list-sessions -f \"#{session_name}\" | grep %1 | while read s; do tmux confirm-before -p \"Kill $s?\" \"kill-session -t $s\"; done"'
```

Press `Alt+K`, type a pattern (e.g., `dev-` or `test`), then confirm each kill individually.

## Practical Example

Clean up old sessions safely:

```bash
tmux list-sessions -f '#{session_name}' | grep '^old-' | while read s; do
  tmux confirm-before -p "Kill session $s?" "kill-session -t $s"
done
```

Each session prompts for confirmation — press `y` to kill or `n` to skip.

## Shell Function

Add to your `.bashrc` or `.zshrc`:

```bash
tmux-kill-pattern() {
  local pattern="${1:-.}"
  tmux list-sessions -f '#{session_name}' | grep "$pattern" | while read s; do
    tmux confirm-before -p "Kill $s?" "kill-session -t $s"
  done
}
```

Usage: `tmux-kill-pattern 'expired-'`
