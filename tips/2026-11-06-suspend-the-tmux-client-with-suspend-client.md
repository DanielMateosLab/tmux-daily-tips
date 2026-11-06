# Suspend the tmux Client with `suspend-client`

**Command:** `suspend-client` (alias `suspendc`)

tmux normally keeps the terminal busy whenever you attach. `suspend-client` sends `SIGTSTP` to the tmux client process, so your outer shell takes control of the terminal. Your sessions keep running on the server. When you resume the client with `fg`, you return to exactly where you were. This is useful for quickly checking something in the outer shell, such as a file or a `git` command, without detaching.

It is not bound by default, so add a binding:

```tmux
# ~/.tmux.conf
# prefix + Ctrl-z suspends the client
bind C-z suspend-client
```

Reload the config:

```sh
tmux source-file ~/.tmux.conf
```

**Example workflow:**

1. You are working in a tmux session in a terminal window.
2. Press `prefix` then `Ctrl-z`. The terminal drops to its shell and prints something like `[1]+ Stopped  tmux attach`.
3. Run whatever you need in that shell, for example:

   ```sh
   git status
   ls ~/Downloads
   ```

4. Type `fg` and press Enter. tmux redraws and you are back in the same pane, with the same layout, scrollback, and running processes.

**Things to know:**

- It works only when tmux is attached in a real terminal with job control. It does nothing useful in a script or a detached session.
- It affects only the client, not the server, so no program inside a pane is interrupted.
- Over SSH, the suspension happens on the local machine's terminal only if the local shell has job control, which is the usual case.
- If you suspend the client without a shell that can resume it, you can run `kill -CONT <pid>` on the client process ID from another terminal. Find it with `pgrep -l tmux`.
