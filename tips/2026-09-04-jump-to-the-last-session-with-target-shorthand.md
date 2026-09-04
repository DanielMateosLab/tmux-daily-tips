# Jump to the Last Session with Target Shorthand

**Command:**
```
tmux attach-session -t =
```

**Explanation:**
tmux supports special session target shorthands to navigate quickly without remembering names. `=` refers to the most recently accessed session, `!` to the most recently modified, `+` to the next in list order, and `-` to the previous.

**Key targets:**
- `=` — most recently accessed
- `!` — most recently modified
- `+` — next session
- `-` — previous session

**Example:**

```bash
# Jump back to the session you just left
tmux attach-session -t =

# Jump to the most recently modified session
tmux attach-session -t !

# Quick alias for frequent use
alias tl='tmux attach-session -t ='
```

**Why it's useful:**
When switching between projects or sessions, `attach-session -t =` is faster than typing a session name or scanning `list-sessions`. Pairs well with `detach` to create fluid session-hopping without breaking context.
