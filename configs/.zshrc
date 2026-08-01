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