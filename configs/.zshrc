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