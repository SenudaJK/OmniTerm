#!/bin/bash
set -e

echo "🚀 Bootstrapping the Ultimate DevOps Terminal..."

# 1. Check for prerequisites
for cmd in git curl zsh; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ $cmd is required but not installed. Please install it and run again."
    exit 1
  fi
done

# 2. Install Oh My Zsh (Unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Clone crucial plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
echo "🔌 Installing Zsh plugins..."
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions || true
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting || true

# 4. Install Starship (The Theme Engine)
if ! command -v starship &> /dev/null; then
  echo "⭐ Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# 5. Backup and inject configurations
echo "⚙️  Setting up configurations..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Backup existing .zshrc
if [ -f "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup_$TIMESTAMP"
fi

# Download your pre-configured dotfiles directly from your GitHub repo
curl -sL https://raw.githubusercontent.com/your-username/your-repo/main/configs/.zshrc -o "$HOME/.zshrc"

mkdir -p "$HOME/.config"
curl -sL https://raw.githubusercontent.com/your-username/your-repo/main/configs/starship.toml -o "$HOME/.config/starship.toml"

# 6. Change default shell to Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🔄 Changing default shell to Zsh. You may be prompted for your password."
  chsh -s $(which zsh)
fi

echo "✅ Installation complete! Please restart your terminal."