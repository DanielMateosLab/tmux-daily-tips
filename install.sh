#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_NAME="com.tmux-tips.daily"
PLIST_SRC="$PROJECT_DIR/$PLIST_NAME.plist"
PLIST_DST="$HOME/Library/LaunchAgents/$PLIST_NAME.plist"

echo "Installing tmux-tips-and-tricks..."

# Create directories
mkdir -p "$PROJECT_DIR/tips"
mkdir -p "$PROJECT_DIR/scripts/logs"

# Make the generator executable
chmod +x "$PROJECT_DIR/scripts/generate-tip.sh"

# Unload existing agent (try both methods unconditionally)
echo "Removing previous agent if present..."
launchctl bootout "gui/$(id -u)/$PLIST_NAME" 2>/dev/null || true
launchctl remove "$PLIST_NAME" 2>/dev/null || true

# Patch the plist with the actual install path
sed "s|__INSTALL_DIR__|$PROJECT_DIR|g" "$PLIST_SRC" > "$PLIST_DST"

# Load the agent
launchctl bootstrap "gui/$(id -u)" "$PLIST_DST"

echo ""
echo "Installed successfully!"
echo "  Agent:    $PLIST_DST"
echo "  Schedule: every day at 06:30 local time"
echo "  Tips dir: $PROJECT_DIR/tips/"
echo "  Logs:     $PROJECT_DIR/scripts/logs/"
echo ""
echo "To test now:  ./scripts/generate-tip.sh"
echo "To verify:    launchctl list | grep tmux-tips"
echo "To uninstall: launchctl bootout gui/\$(id -u)/$PLIST_NAME && rm $PLIST_DST"
