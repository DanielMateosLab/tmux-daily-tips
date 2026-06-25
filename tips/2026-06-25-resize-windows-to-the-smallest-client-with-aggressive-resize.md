# Resize Windows to the Smallest Client with aggressive-resize

When the same window is attached by two clients of different sizes, tmux normally constrains the window to the size of the *smallest session* viewing it — even if the client you care about is bigger. The `aggressive-resize` window option flips this: the window is sized to the smallest client *actively looking at that window*, not every client attached to the session.

## The option

```tmux
# In ~/.tmux.conf
set-window-option -g aggressive-resize on
```

Or toggle it live for the current window:

```tmux
# prefix : then type
setw aggressive-resize on
```

## Why it matters

Picture a session attached by two clients:

- **Laptop** (80×24) sitting on window 1
- **Desktop** (200×50) working on window 2

With the default (`off`), window 2 is squeezed down to 80×24 because the laptop is *attached to the session*, even though it's parked on a different window. You waste two-thirds of your desktop screen.

With `aggressive-resize on`, tmux only counts clients **currently displaying** that window. Window 2 expands to the full 200×50 of the desktop, while window 1 stays at 80×24 for the laptop. Each window fits whoever is actually viewing it.

## Concrete example

```bash
# Terminal A (small)
tmux new-session -s shared
# create a second window, then detach focus to window 0

# Terminal B (large), attach to the same session
tmux attach -t shared
# switch to window 1 and work full-size
tmux select-window -t shared:1
```

Toggle it on and watch window 1 grow:

```tmux
setw -g aggressive-resize on
```

## Notes

- This only affects windows shared by multiple clients; solo sessions are unaffected.
- It pairs well with grouped sessions (`new-session -t`), where each client can roam to different windows independently.
- Leave it `off` if you rely on every client always seeing an identical, mirrored layout.
