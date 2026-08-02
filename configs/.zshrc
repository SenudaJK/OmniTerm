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
alias azg="az group list -o table"

kctx() {
  if ! command -v kubectl >/dev/null 2>&1; then
    echo "kubectl is not installed."
    return 1
  fi

  if [ $# -eq 0 ]; then
    local current_context
    current_context=$(kubectl config current-context 2>/dev/null || true)

    echo "Current context: ${current_context:-none}"
    local context
    context=$(kubectl config get-contexts -o name 2>/dev/null | fzf --height=40% --reverse --prompt='Select context: ')

    if [ -n "$context" ]; then
      kubectl config use-context "$context"
      echo "Switched to context: $context"
    else
      echo "No context selected."
      return 1
    fi
  else
    kubectl config use-context "$1"
    echo "Switched to context: $1"
  fi
}

omni-help() {
  echo "OmniTerm shortcuts"
  echo "  kctx            Switch Kubernetes context interactively"
  echo "  kctx <name>     Switch to a specific context"
  echo "  omniterm-update Update OmniTerm shell config"
  echo "  omniterm-theme  Change the Starship theme"
  echo "  ghb             Create a new git branch"
  echo "  ghm             Switch to main branch"
  echo "  ghs             Show git status"
  echo "  gha             Stage all changes"
  echo "  ghc <msg>       Commit changes"
  echo "  ghps            Push changes"
  echo "  ghpl            Pull changes"
}

# Custom Git Shortcuts
alias ghb="git checkout -b"     # Create and switch to a new branch
alias ghm="git checkout main"   # Switch to main branch
alias ghs="git status"          # Check working tree status
alias gha="git add ."           # Stage all changes
alias ghc="git commit -m"       # Commit with a message (Usage: ghc "your message")
alias ghps="git push"           # Push changes
alias ghpl="git pull"           # Pull latest changes
alias ghsh="git stash"          # Stash 
alias ghshp="git stash pop"     # Pop the latest stash

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

# ---------------------------------------------------------
# User Custom Aliases & Configurations
# ---------------------------------------------------------
# This file is safe from omniterm-update overwrites.
if [ -f "$HOME/.omniterm_custom" ]; then
  source "$HOME/.omniterm_custom"
fi

# ---------------------------------------------------------
# Zoxide (Smarter 'cd' navigation)
# ---------------------------------------------------------
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi