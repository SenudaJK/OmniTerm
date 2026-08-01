export ZSH="$HOME/.oh-my-zsh"

# Enable all the DevOps plugins
plugins=(
  git
  docker
  kubectl
  helm
  azure
  aws
  terraform
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Initialize Starship theme
eval "$(starship init zsh)"

# Helpful Aliases
alias k="kubectl"
alias kctx="kubectl config use-context"
alias azg="az group list -o table"

# Custom Git Shortcuts
alias ghb="git checkout -b"     # Create and switch to a new branch
alias ghm="git checkout main"   # Switch to main branch
alias ghs="git status"          # Check working tree status
alias gha="git add ."           # Stage all changes
alias ghc="git commit -m"       # Commit with a message (Usage: ghc "your message")
alias ghps="git push"           # Push changes
alias ghpl="git pull"           # Pull latest changes

# ---------------------------------------------------------
# OmniTerm Auto-Updater
# ---------------------------------------------------------
function omniterm-update() {
  echo "🔄 Pulling latest OmniTerm configurations..."
  
  # Fetch latest Zsh aliases/plugins
  # We output to a temporary file first to avoid breaking the active session during download
  curl -sL https://raw.githubusercontent.com/SenudaJK/OmniTerm/main/configs/.zshrc -o "$HOME/.zshrc.tmp" && mv "$HOME/.zshrc.tmp" "$HOME/.zshrc"
  
  # Reload terminal
  source ~/.zshrc
  echo "✅ OmniTerm updated successfully!"
}

# ---------------------------------------------------------
# OmniTerm Theme Switcher
# ---------------------------------------------------------
function omniterm-theme() {
  echo ""
  echo "🎨 Choose your OmniTerm aesthetic:"
  echo "  1) Default (Standard Cloud Colors)"
  echo "  2) Cyberpunk (Neon Pink & Purple)"
  echo "  3) Hacker (Matrix Green)"
  echo ""
  
  # Zsh-compatible read prompt
  echo -n "Enter your choice [1-3] (Default: 1): "
  read theme_choice

  case "$theme_choice" in
    2)
      THEME="cyberpunk.toml"
      echo "👾 Applying Cyberpunk theme..."
      ;;
    3)
      THEME="hacker.toml"
      echo "📟 Applying Hacker theme..."
      ;;
    *)
      THEME="default.toml"
      echo "☁️  Applying Default theme..."
      ;;
  esac

  curl -sL "https://raw.githubusercontent.com/SenudaJK/OmniTerm/main/configs/themes/$THEME" -o "$HOME/.config/starship.toml"
  
  # Refresh the prompt
  source ~/.zshrc
  echo "✅ Theme updated successfully!"
}