# Jump to Any Prompt with Shell Integration and Previous-Prompt Navigation

**Shortcut:** `prefix + [` then `N` / `Shift+N` (in copy mode with shell integration enabled)

Tmux 3.2+ can track shell prompts as semantic markers inside a pane's scrollback. Once your shell emits the right escape sequence on each prompt, you can jump backward and forward between prompts in copy mode — no scrolling, no searching for `$`.

## How it works

Your shell must emit `OSC 133;A` (the "prompt start" marker) before printing each prompt. Tmux records those positions and lets you navigate them with `M-Up` / `M-Down` while in copy mode.

Add to your shell config:

```bash
# Bash / Zsh
PS1=$'\001\e]133;A\e\\\002'"$PS1"
```

```zsh
# Cleaner zsh version
precmd() { print -Pn "\e]133;A\e\\" }
```

Then in `~/.tmux.conf`:

```tmux
bind-key -T copy-mode-vi M-Up   send-keys -X previous-prompt
bind-key -T copy-mode-vi M-Down send-keys -X next-prompt
```

## Example

You ran 30 commands in a long-running pane and want to review the output of three commands ago:

1. Enter copy mode: `prefix + [`
2. Press `M-Up` three times — the cursor jumps to the start of the prompt three commands back
3. Review the output between that prompt and the next
4. Press `M-Down` to jump forward one command at a time

Bonus: use `-o` to land on the prompt's **output** instead of the prompt line itself:

```tmux
bind-key -T copy-mode-vi M-PageUp send-keys -X previous-prompt -o
```

This is far faster than `Ctrl+R` search when you just want "the last thing I ran" or "three commands ago" — tmux knows exactly where prompts live.
