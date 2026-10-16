# Show tmux Server Options with `show-options -s`

Most tmux tips focus on session, window, or pane options. Server options (`-s`) control behavior that applies to the whole tmux server, such as `escape-time`, `exit-empty`, and `default-terminal`. Use `show-options -s` to inspect them without guessing.

## Command

```sh
tmux show-options -s
```

Add a name to view one option:

```sh
tmux show-options -s escape-time
```

## Explanation

Server options are global to the running tmux server and are shared by every session and client. Because they are set once for the whole server, it is easy to forget what value is currently in effect, especially if a config file was sourced partway through or another client changed it.

`show-options -s` prints every server option and its current value. Adding an option name prints just that one. This is a quick way to confirm a setting took effect after editing your config, without restarting the server.

Use `-v` to print only the value, which is handy in scripts:

```sh
tmux show-options -sv escape-time
```

## Example

Check whether `escape-time` is set to a low value before deciding to change it:

```sh
$ tmux show-options -sv escape-time
500
```

If you see `500` and expected `10`, your config was not loaded. Reload it, then check again:

```sh
tmux source-file ~/.tmux.conf
tmux show-options -sv escape-time
```

To set a server option from the command line, use `set-option -s`:

```sh
tmux set-option -s escape-time 10
```

Pair this with `show-options -s` in a quick debugging session to confirm the change before relying on it.
