# Watch Files and Automatically Rerun Commands with entr in tmux

**Shortcut:** `send-keys -t window.pane 'entr -c bash -c "make test"' Enter`

**What it does:**
Use `entr`, a file monitor utility, inside a tmux pane to automatically rerun commands whenever specified files change. This eliminates the manual "save → switch to terminal → run command" cycle.

**Setup:**
Install `entr` (macOS: `brew install entr`, Linux: `apt install entr`). Then send the command to a pane:

```bash
tmux send-keys -t 1 'ls src/*.go | entr -c sh -c "go test ./..."' Enter
```

The `-c` flag clears the screen before each run, keeping the pane uncluttered.

**Example workflow:**
Create a side pane for continuous testing while editing:

```bash
tmux split-window -h -c ~/project
tmux send-keys -t 1.1 'ls src/**/*.ts | entr -c sh -c "npm test"' Enter
```

Now every time you save a TypeScript file, the tests rerun automatically in the right pane while you edit in the left.

**Advanced:**
- Use `find` to watch multiple patterns: `find . -name '*.rs' -o -name 'Cargo.toml' | entr -c cargo build`
- Combine with other tools: `ls app/** | entr -c sh -c "eslint . && prettier --write ."`
- Add `-r` flag to restart a server instead of just rerunning: `entr -rc ./start-server.sh`
