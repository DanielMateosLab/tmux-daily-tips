# tmux tips and tricks

A self-growing repository of tmux tips. On weekdays (Mon-Fri) at 05:00, 10:05, and 15:10 (local time) a launchd agent invokes Claude CLI to generate a new markdown tip that doesn't duplicate any existing one. The 05:00 run kicks off a rate-limit session early so it resets predictably at 10:00; the 10:05 and 15:10 runs each follow shortly after a reset.

## How it works

1. `scripts/generate-tip.sh` collects all existing tip filenames from `tips/`
2. It builds a prompt telling Claude to pick a topic not already covered
3. Claude generates a short, practical markdown tip
4. The tip is saved as `tips/YYYY-MM-DD-short-description.md`
5. If inside a git repo, it auto-commits and pushes

The macOS launchd agent runs this three times on each weekday — even if the screen is locked. If the laptop was asleep at trigger time, the job fires as soon as it wakes up.

## Project structure

```
tmux-tips-and-tricks/
  tips/                             # generated tips (one per day)
  scripts/
    generate-tip.sh                 # tip generator script
    logs/                           # debug logs from each run
  com.tmux-tips.daily.plist         # launchd agent template
  install.sh                        # one-time setup
```

## Architecture

### Generator (`scripts/generate-tip.sh`)

- Lists all `tips/*.md` filenames and passes them to Claude as context so it never repeats a topic
- Calls `claude --print --dangerously-skip-permissions` for fully unattended, non-interactive output
- Extracts the slug from the generated markdown `#` heading (lowercased, hyphenated)
- Saves to `tips/YYYY-MM-DD-<slug>.md` — idempotent on the same day (overwrites)
- Optionally commits and pushes; failures are silenced so the tip is still saved

### Scheduler (`com.tmux-tips.daily.plist`)

A macOS LaunchAgent using `StartCalendarInterval` as an array of entries — one per (weekday, time) pair — covering Mon-Fri at 05:00, 10:05, and 15:10.

Key behaviors:
- Runs under the logged-in user session, so it works even when the screen is locked
- If the Mac was asleep at a trigger time, launchd fires the job on wake — no missed runs
- `install.sh` patches `__INSTALL_DIR__` placeholders with the actual repo path before copying to `~/Library/LaunchAgents/`
- Stdout/stderr are routed to `scripts/logs/` for debugging

### Deduplication

The generator passes every existing filename to the prompt. Claude uses these to avoid repeating topics. Since filenames contain descriptive slugs (e.g. `2026-02-26-split-panes-vertically.md`), this gives enough signal without reading full file contents.

## Install

```bash
./install.sh
```

This will:
- Create required directories
- Copy the launchd plist to `~/Library/LaunchAgents/`
- Load the agent

## Test manually

```bash
./scripts/generate-tip.sh
```

## Verify the agent is loaded

```bash
launchctl list | grep tmux-tips
```

## Uninstall

```bash
launchctl unload ~/Library/LaunchAgents/com.tmux-tips.daily.plist
rm ~/Library/LaunchAgents/com.tmux-tips.daily.plist
```

## Requirements

- macOS (uses launchd)
- [Claude CLI](https://docs.anthropic.com/en/docs/claude-code) installed and on PATH
