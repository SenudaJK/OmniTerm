#!/bin/bash
set -e

echo "🗑️  Removing OmniTerm configurations..."

# 1. Remove the OmniTerm configs
if [ -f "$HOME/.config/starship.toml" ]; then
  rm "$HOME/.config/starship.toml"
  echo "Removed Starship configuration."
fi

if [ -f "$HOME/.zshrc" ]; then
  rm "$HOME/.zshrc"
  echo "Removed OmniTerm .zshrc."
fi

# 2. Find and restore the most recent backup
# This lists all files matching the backup pattern, sorts by time, and picks the newest one
LATEST_BACKUP=$(ls -t "$HOME"/.zshrc.backup_* 2>/dev/null | head -n 1)

if [ -n "$LATEST_BACKUP" ]; then
  echo "📦 Found backup: $LATEST_BACKUP"
  mv "$LATEST_BACKUP" "$HOME/.zshrc"
  echo "✅ Original .zshrc restored successfully!"
else
  echo "⚠️  No automatic backup found. Generating a default Zsh configuration..."
  # Failsafe: if they deleted their backup, give them the default Oh My Zsh template
  cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc" 2>/dev/null \vert{}\vert{} touch "$HOME/.zshrc"
fi

echo ""
echo "OmniTerm has been removed. Please restart your terminal to see your original setup."