#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TIPS_DIR="$PROJECT_DIR/tips"
LOG_DIR="$SCRIPT_DIR/logs"
TODAY="$(date +%Y-%m-%d)"
NOW="$(date +%Y-%m-%d-%H%M)"

mkdir -p "$TIPS_DIR" "$LOG_DIR"

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

# Generate the tip
LOG_FILE="$LOG_DIR/$NOW.log"
RAW_OUTPUT="$(echo "$PROMPT" | claude -p --model haiku --tools '' 2>"$LOG_FILE")"

if [ -z "$RAW_OUTPUT" ]; then
  echo "Error: claude produced no output. Check $LOG_FILE" >&2
  exit 1
fi

# Extract slug from the first markdown heading
TITLE="$(echo "$RAW_OUTPUT" | grep -m1 '^#\s' | sed 's/^#\s*//')"
if [ -z "$TITLE" ]; then
  SLUG="tip"
else
  SLUG="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')"
fi

# Truncate slug to keep filename reasonable
SLUG="$(echo "$SLUG" | cut -c1-60)"

OUTPUT_FILE="$TIPS_DIR/$TODAY-$SLUG.md"
echo "$RAW_OUTPUT" > "$OUTPUT_FILE"
echo "Tip saved to $OUTPUT_FILE"

# Log the generation
echo "[$TODAY] Generated: $(basename "$OUTPUT_FILE")" >> "$LOG_FILE"

# Optional: commit and push if inside a git repo
if git -C "$PROJECT_DIR" rev-parse --is-inside-work-tree &>/dev/null; then
  git -C "$PROJECT_DIR" add "$OUTPUT_FILE" 2>/dev/null || true
  git -C "$PROJECT_DIR" commit -m "Add tip: $TODAY-$SLUG" 2>/dev/null || true
  git -C "$PROJECT_DIR" push 2>/dev/null || true
fi
