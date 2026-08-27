# Create a persistent log of all pane output

## Command

`pipe-pane -o 'tee -a ~/.tmux/logs/pane-#{session_name}-#{window_index}-#{pane_index}.log'`

## Explanation

`pipe-pane -o` continuously streams a pane's output (not input) to a command. Piping to `tee -a` appends everything to a log file in real-time while still displaying it in the pane. This captures complete records of service output, test runs, or deployments that would otherwise scroll past your scrollback buffer.

Run `pipe-pane -o` again with no command to stop logging.

## Example

Bind it to a key in your config:

```
bind-key L pipe-pane -o 'tee -a ~/.tmux/logs/#{session_name}-#{window_index}-#{pane_index}.log'
```

Then press `Prefix + L` in any pane to start logging. All output flows to both the pane and a timestamped log file:

```
$ grep -r "error" ~/.tmux/logs/
$ tail -f ~/.tmux/logs/work-0-1.log
```

Stops on second press of the same key. Useful for background services, CI jobs, or debugging long-running processes where you need to inspect output hours later.
