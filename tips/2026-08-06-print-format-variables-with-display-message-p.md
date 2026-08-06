# Print Format Variables With display-message -p

The `-p` flag for `display-message` prints the output to stdout instead of displaying in the status bar. This is essential for capturing format variables in shell scripts, debugging configurations, and conditional logic.

Command: `tmux display-message -p "#{format_variable}"`

Example: Get the current session and window info:

```bash
$ tmux display-message -p "Session: #{session_name}, Window: #{window_name}"
Session: work, Window: editor
```

Example: Store the pane's process ID for later manipulation:

```bash
PID=$(tmux display-message -p "#{pane_pid}")
kill $PID  # Kill the process running in that pane
```

Example: Create a function to monitor session state:

```bash
tmux_info() {
  tmux display-message -p "[#{session_name}] #{window_name} (#{pane_title})"
}
```

Example: Check if a pane has unsaved changes (if your shell sets pane-title):

```bash
tmux display-message -p "#{pane_title}" | grep -q "*" && echo "Unsaved"
```

Without `-p`, messages flash in the status bar. With `-p`, you get data you can pipe, store, and process—perfect for automation and debugging complex tmux setups.
