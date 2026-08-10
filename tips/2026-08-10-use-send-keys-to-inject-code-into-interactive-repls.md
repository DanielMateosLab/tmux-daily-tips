# Use send-keys to inject code into interactive REPLs

When working with Python, Node.js, Ruby, or other interactive shells, you can use `send-keys` to inject code directly without manually typing it.

## Command

```
send-keys -t <target> "<code>" Enter
```

## Explanation

This sends code to an interactive shell (REPL) as if you typed it, with automatic newline execution. Useful for running snippets from files, templates, or programmatically generated commands while keeping your hands free for other work.

## Example

Open a Python REPL in a pane:

```
tmux new-window -n python "python3"
```

Inject and execute code:

```
tmux send-keys -t python "import json; data = {'key': 'value'}; print(json.dumps(data))" Enter
```

Send a multi-line function definition (without Enter until the end):

```
tmux send-keys -t python "def greet(name):" Enter
tmux send-keys -t python "    return f'Hello, {name}!'" Enter
tmux send-keys -t python "greet('World')" Enter
```

Capture the result:

```
tmux capture-pane -t python -p | tail -1
```

## Use Cases

- Automating testing sequences in interactive shells
- Populating data in databases or APIs from scripts
- Running parameterized commands from configuration files
- Testing code snippets without leaving tmux
