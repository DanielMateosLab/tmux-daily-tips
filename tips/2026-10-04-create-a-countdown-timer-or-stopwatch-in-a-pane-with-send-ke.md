# Create a Countdown Timer or Stopwatch in a Pane with send-keys

**Shortcut/Command:**
```
tmux send-keys -t pane "for i in {10..1}; do clear; echo \"Time: \$i\"; sleep 1; done; echo Done!" Enter
```

**Explanation:**
Use `send-keys` to inject a countdown loop into a pane without manually typing it. This is useful for time-boxing work sessions, running time-limited tests, or visible countdowns during demos. The `clear` command keeps the display clean, and you can customize the starting number, message, and actions on completion.

**Practical Examples:**

Create a 60-second timer for a focused work block:
```
tmux send-keys -t work "for i in {60..1}; do clear; printf 'Focused work: %02d seconds\\r' \$i; sleep 1; done; echo DONE" Enter
```

Create a stopwatch that runs until manually stopped:
```
tmux send-keys -t timer "i=0; while true; do clear; printf 'Elapsed: %02d:%02d\\r' \$((i/60)) \$((i%60)); ((i++)); sleep 1; done" Enter
```

Run a test with a 30-second timeout before cleanup:
```
tmux send-keys -t test "timeout 30 ./my_test.sh; echo 'Test finished'; sleep 2" Enter
```

Send a countdown to a specific window without switching focus:
```
bind-key T send-keys -t utility "countdown() { for i in {5..1}; do echo \$i; sleep 1; done; }; countdown" Enter
```

**Why it's useful:** Visible timers keep you accountable, help with time-boxed testing, and make demos more engaging without requiring separate tools.
