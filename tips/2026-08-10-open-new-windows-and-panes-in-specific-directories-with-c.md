# Open New Windows and Panes in Specific Directories with -c

Use the `-c` flag with `new-window` or `split-window` to open a pane or window directly in a specific working directory, without changing the current session's default or manually navigating there afterward.

## Command

```
new-window -c /path/to/directory
split-window -h -c /path/to/directory
```

## Explanation

When you create a new window or split a pane, tmux normally opens it in the current pane's working directory. The `-c` flag overrides this for just that pane or window, useful for multi-directory workflows where you want to isolate work by location.

This avoids the awkward pattern of `new-window` then `cd /path`.

## Examples

Open a new window for a project in `~/projects/api`:
```
new-window -c ~/projects/api
```

Split horizontally and open `~/.config` in the new pane:
```
split-window -h -c ~/.config
```

Combine with naming for a fully configured new window:
```
new-window -n "logs" -c /var/log
```

In your `.tmux.conf`, bind a key to quickly open a split in a frequently-used directory:
```
bind-key C-d split-window -h -c ~/Downloads
```

Now `prefix + Ctrl-d` opens a new split in Downloads, ready to work.
