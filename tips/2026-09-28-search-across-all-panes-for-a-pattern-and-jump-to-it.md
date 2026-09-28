# Search Across All Panes for a Pattern and Jump to It

**Command:** `list-panes`, `capture-pane`, `select-pane`, and a shell loop

**Shortcut to add to `.tmux.conf`:**

```tmux
bind-key F command-prompt -p "Search all panes:" \
  "run-shell 'for pane in $(tmux list-panes -a -F \"#{pane_id}\"); do \
    if tmux capture-pane -p -t \"$pane\" -S -100 | grep -q \"%1\"; then \
      tmux select-pane -t \"$pane\"; \
      break; \
    fi; \
  done'"
```

**What it does:**

When you press `Prefix F`, you're prompted for a search term. tmux searches the scrollback history of all panes in the current session, starting from the most recent. When it finds a match, it automatically selects that pane so you can see the context. This is faster than manually switching between panes to hunt for something.

**Why it's useful:**

- Quickly locate error messages, log entries, or output across multiple panes
- No need to remember which pane a piece of information appeared in
- Combines searching with navigation in one command

**Example:**

You have three panes running different services. You see an error but don't remember which pane it appeared in. Press `Prefix F`, type the error message, and tmux jumps directly to the pane containing it.
