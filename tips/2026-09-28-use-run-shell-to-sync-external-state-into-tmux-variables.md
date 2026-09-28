# Use run-shell to sync external state into tmux variables

Dynamically update tmux variables by executing external commands with `run-shell`. This lets you display live system data, Git state, or any external condition in your status bar or pane titles without polling manually.

## Shortcut

```
set-hook -g session-created 'run-shell "echo $(whoami)@$(hostname) | tmux set-user-option myinfo"'
send-keys -t $pane "tmux set-user-option myload \"$(uptime | awk -F: '{print $NF}')\"" Enter
```

## Explanation

`run-shell` executes shell commands asynchronously. By piping the output back into `tmux set-user-option`, you can capture command results and store them as variables accessible in your status bar or in scripts.

This is cleaner than embedding complex shell expansions in your config—it separates data fetching from display logic.

## Example

Store current Git branch and system load in user options, then display them in the status bar:

```tmux
# In your .tmux.conf
set-hook -g session-created 'run-shell "cd #{client_cwd} && git rev-parse --abbrev-ref HEAD 2>/dev/null | tmux set-user-option gitbranch"'

set-option -g status-right '#[fg=green]#{user_option:gitbranch} #[fg=blue]#{user_option:sysload} #[fg=default]%H:%M'

# Refresh every 5 seconds
set-hook -g window-changed 'run-shell "echo $(uptime | grep -oE \"load average.*\" | cut -d, -f1) | tmux set-user-option sysload"'
```

Now your status bar shows live Git branches and system metrics. The `run-shell` background execution prevents tmux from blocking while fetching data.
