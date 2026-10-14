# Paste multi-line text safely with paste-buffer -p

Pasting a multi-line snippet into a pane normally sends each newline as Enter, so a shell or REPL executes every line the moment it arrives. That breaks indented blocks, half-finished functions, and anything you want to review first. `paste-buffer -p` wraps the paste in bracketed-paste escape sequences, which tells the receiving program "this is a paste, not typing." Modern shells and editors (bash, zsh, fish, vim, Python's REPL) then insert the whole block as one edit instead of executing line by line.

## Usage

Load the text into a buffer, then paste it with `-p`:

```sh
tmux load-buffer snippet.py
tmux paste-buffer -p -t work:0.1
```

Or from inside tmux, with the prefix key:

```
prefix :
paste-buffer -p -t work:0.1
```

Without `-p`, the same buffer is sent as raw keystrokes and every newline becomes Enter.

## Example

Suppose `snippet.py` contains:

```python
def greet(name):
    print(f"hello, {name}")

greet("world")
```

Running `tmux paste-buffer -p -t dev:0.1` into a Python REPL pane inserts all four lines as one block. The REPL shows the function definition, waits for you to press Enter once, and then runs it. Without `-p`, the REPL would execute `def greet(name):` as an incomplete statement and garble the indentation of the following lines.

## Notes

- The receiving program must support bracketed paste. Most modern shells and REPLs do; if a program does not, the escape sequences appear as literal junk, so test on a throwaway pane first.
- Combine with `-d` to delete the buffer after pasting, which keeps your paste-buffer list tidy.
- Use `choose-buffer` (prefix `=`) to pick which snippet to paste when you have several loaded.
