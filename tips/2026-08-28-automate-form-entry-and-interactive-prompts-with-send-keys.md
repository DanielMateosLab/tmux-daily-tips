# Automate form entry and interactive prompts with send-keys

**Command:**
```
tmux send-keys -t pane 'field_value' Tab
tmux send-keys -t pane 'next_field' Tab
tmux send-keys -t pane Enter
```

**Explanation:**
Chain `send-keys` commands to programmatically fill and submit interactive terminal forms, automating repetitive data entry or multi-step setup wizards without manual interaction.

**Example:**
```bash
# Automate database connection prompt
tmux send-keys -t db 'localhost' Tab
tmux send-keys -t db 'myuser' Tab
tmux send-keys -t db 'mypassword' Tab
tmux send-keys -t db Enter

# Or with a wrapper function
function setup-db() {
  local host=$1 user=$2 pass=$3
  tmux send-keys -t db "$host" Tab
  tmux send-keys -t db "$user" Tab
  tmux send-keys -t db "$pass" Tab
  tmux send-keys -t db Enter
}

setup-db prod.example.com admin secret123
```

**Tips:**
- Use Tab to navigate between fields
- Use `-l` flag to send literal text when special characters are involved
- Pause between sends with `sleep` if the application is slow to respond
- Combine with `send-keys C-c` to handle errors or cancellations
