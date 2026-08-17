# Display the current git branch in the window status bar

The status bar can show useful context about your current pane. A practical example is displaying the git branch of the pane's working directory so you're always aware of which branch you're on.

## The Configuration

```tmux
set-option -g status-right "#(cd #{pane_current_path} && git branch --show-current 2>/dev/null || echo '-') | %H:%M"
```

## How it Works

The format string interpolates at runtime:
1. Changes to the pane's working directory using `#{pane_current_path}`
2. Runs `git branch --show-current` to fetch the active branch name
3. Falls back to `-` if not in a git repository
4. Displays the result on the right side of the status bar with the time

## Example

In a git repository on the `main` branch:
```
main | 14:32
```

In a directory without git:
```
- | 14:32
```

This works per-pane, so switching between panes in different repositories automatically updates the display.
