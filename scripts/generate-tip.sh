#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TIPS_DIR="$PROJECT_DIR/tips"
LOG_DIR="$SCRIPT_DIR/logs"
TODAY="$(date +%Y-%m-%d)"
NOW="$(date +%Y-%m-%d-%H%M)"
LOG_FILE="$LOG_DIR/$NOW.log"

mkdir -p "$TIPS_DIR" "$LOG_DIR"

# Failures go to the log, to stderr (launchd-stderr.log) and, when oracle's
# notifier is on PATH, to Telegram. The 05:00 run exists to open a rate-limit
# window, so a silent failure costs a whole day's schedule.
notify() {
  echo "[$NOW] $1" | tee -a "$LOG_FILE" >&2
  if command -v oracle-notify >/dev/null 2>&1; then
    oracle-notify --title "tmux-tips · $(hostname -s)" "$1" >>"$LOG_FILE" 2>&1 || true
  fi
}

in_git() { git -C "$PROJECT_DIR" rev-parse --is-inside-work-tree &>/dev/null; }
git_dir() { git -C "$PROJECT_DIR" rev-parse --absolute-git-dir; }
rebasing() { [ -d "$(git_dir)/rebase-merge" ] || [ -d "$(git_dir)/rebase-apply" ]; }

# Another machine pushes tips to the same remote. Sync first, so its tips count
# for dedup and a same-named file is seen before we write ours.
if in_git; then
  if rebasing; then
    git -C "$PROJECT_DIR" rebase --abort >>"$LOG_FILE" 2>&1 || true
    notify "Found a rebase left over from a previous run and aborted it."
  fi
  git -C "$PROJECT_DIR" pull --rebase --autostash >>"$LOG_FILE" 2>&1 \
    || notify "git pull failed before generating; continuing with the local copy. See $LOG_FILE"
fi

# Collect existing tip filenames for dedup
EXISTING_TIPS=""
for f in "$TIPS_DIR"/*.md; do
  [ -e "$f" ] || continue
  EXISTING_TIPS="$EXISTING_TIPS
- $(basename "$f")"
done

PROMPT="You are a tmux expert. Generate a single, practical tmux tip as a markdown file.

Requirements:
- Pick a tmux shortcut, feature, or workflow trick NOT already covered below
- Write a short, practical markdown file with: a title (# heading), the shortcut/command, a clear explanation, and a concrete example
- Keep it concise (under 80 lines)
- Do NOT wrap the output in a code fence — output raw markdown only

Existing tips (do NOT duplicate these):
$EXISTING_TIPS

Output ONLY the markdown content, nothing else."

# Generate the tip. `claude -p` prints its errors (expired login, usage limit)
# on stdout, so stdout is kept and logged when the call fails.
if ! RAW_OUTPUT="$(echo "$PROMPT" | claude -p --model haiku --tools '' 2>>"$LOG_FILE")"; then
  echo "$RAW_OUTPUT" >>"$LOG_FILE"
  notify "claude failed, so this run opened no rate-limit window: $(echo "$RAW_OUTPUT" | head -c 300)"
  exit 1
fi
if [ -z "$RAW_OUTPUT" ]; then
  notify "claude produced no output. See $LOG_FILE"
  exit 1
fi

# Extract slug from the first markdown heading
TITLE="$(echo "$RAW_OUTPUT" | grep -m1 '^#\s' | sed 's/^#\s*//' || true)"
if [ -z "$TITLE" ]; then
  SLUG="tip"
else
  SLUG="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')"
fi

# Truncate slug to keep filename reasonable
SLUG="$(echo "$SLUG" | cut -c1-60)"

# Never overwrite a tip, ours or the other machine's
OUTPUT_FILE="$TIPS_DIR/$TODAY-$SLUG.md"
n=2
while [ -e "$OUTPUT_FILE" ]; do
  OUTPUT_FILE="$TIPS_DIR/$TODAY-$SLUG-$n.md"
  n=$((n + 1))
done

echo "$RAW_OUTPUT" > "$OUTPUT_FILE"
echo "Tip saved to $OUTPUT_FILE"
echo "[$TODAY] Generated: $(basename "$OUTPUT_FILE")" >> "$LOG_FILE"

# Commit and push. A conflict is aborted, never left behind: a stuck rebase
# blocked every commit from 2026-11-06 on.
if in_git; then
  NAME="$(basename "$OUTPUT_FILE" .md)"
  git -C "$PROJECT_DIR" add "$OUTPUT_FILE" >>"$LOG_FILE" 2>&1
  git -C "$PROJECT_DIR" commit -m "Add tip: $NAME" >>"$LOG_FILE" 2>&1 \
    || { notify "git commit failed for $NAME. See $LOG_FILE"; exit 1; }
  if ! git -C "$PROJECT_DIR" pull --rebase --autostash >>"$LOG_FILE" 2>&1; then
    if rebasing; then git -C "$PROJECT_DIR" rebase --abort >>"$LOG_FILE" 2>&1 || true; fi
    notify "git pull --rebase failed after committing $NAME; rebase aborted, tip committed locally only. See $LOG_FILE"
    exit 1
  fi
  GIT_TERMINAL_PROMPT=0 git -C "$PROJECT_DIR" push >>"$LOG_FILE" 2>&1 \
    || { notify "git push failed for $NAME. See $LOG_FILE"; exit 1; }
fi
