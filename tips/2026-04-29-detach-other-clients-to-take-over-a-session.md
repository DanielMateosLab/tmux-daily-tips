# Detach Other Clients to Take Over a Session

When multiple clients are attached to the same tmux session, the smallest client's screen size constrains everyone. Use `detach-client -a` to kick off all *other* clients while keeping yours connected — useful when an old SSH session is still attached from another machine and squashing your layout.

## Shortcut

- `prefix` + `D` — choose a specific client to detach (interactive list)
- `:detach-client -a` — detach **all other** clients, keep yours
- `:detach-client -s <session>` — detach every client from a named session

## Why it matters

Tmux sizes each window to the smallest attached client. A forgotten laptop attached over SSH at 80×24 will shrink your 200-column terminal until you detach it. `-a` ("all but me") fixes this in one command without hunting through a client list.

## Example

You SSH into a server from your desktop and find your panes mysteriously squeezed:

```
$ tmux list-clients
/dev/pts/0: 0 [80x24 xterm] (utf8)
/dev/pts/3: 0 [220x60 xterm-256color] (utf8)
```

An old client is still hanging on at 80×24. Reclaim full size:

```
prefix : detach-client -a
```

Your session immediately resizes to your current terminal's dimensions. Bind it for one-keypress access:

```tmux
bind D detach-client -a
```

Now `prefix D` boots ghost clients instantly — no list, no fuss.
