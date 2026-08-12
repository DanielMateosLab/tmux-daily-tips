# Discover Available tmux Commands with `list-commands`

**The Command:**

`tmux list-commands`

**What It Does**

Prints every tmux command with its syntax and description. Use it to explore commands, verify syntax, or dynamically check for command availability in scripts.

**Practical Examples**

- List all commands with full syntax:
  ```
  tmux list-commands
  ```

- Count available commands:
  ```
  tmux list-commands | wc -l
  ```

- Find commands matching a keyword:
  ```
  tmux list-commands | grep pane
  ```

- Extract just command names:
  ```
  tmux list-commands | awk '{print $1}' | sort
  ```

- Verify a command exists before using it in a script:
  ```
  tmux list-commands | grep -q '^send-keys' && echo "send-keys is available"
  ```

**Sample Output**

```
attach-session [-dEr] [-c working-directory] [-t target-session]
bind-key [-nr] [-t key-table] key command [arguments]
send-keys [-FHlXRSJ] [-t target-pane] keys [keys ...]
```

Invaluable for shell scripts that conditionally call tmux, learning command syntax on the fly, or discovering lesser-known commands you didn't know existed.
