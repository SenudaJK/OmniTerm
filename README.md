# 🚀 CloudShell Bootstrapper

The ultimate, one-command terminal environment for DevOps engineers, cloud architects, and developers. 

This script automates the setup of a high-performance, context-aware Zsh terminal equipped with Oh My Zsh, Starship, and essential plugins. It dynamically displays active Azure, AWS, and Kubernetes (AKS) contexts right in your prompt to prevent accidental deployments to the wrong environment.

![Terminal Preview](https://via.placeholder.com/800x400?text=Insert+a+screenshot+of+your+terminal+here)

## ✨ Features
* **Zero-Touch Setup:** Installs Zsh, Oh My Zsh, and Starship automatically.
* **Cloud & Container Aware:** Instantly see your active `kubectl` context, Azure subscription, and AWS profile.
* **Developer Ergonomics:** Pre-configured with syntax highlighting and auto-suggestions (like Fish shell).
* **Safe Installation:** Automatically backs up your existing `.zshrc` before applying the new configuration.

---

## ⚠️ Prerequisites: Install a Nerd Font

This terminal configuration uses special icons for cloud providers (☁️, 󰠅, ☸). **You MUST install a Nerd Font before running the installer**, or these icons will appear as broken boxes (`?` or `□`).

We recommend **[MesloLGS NF](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)** or **[FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads)**.

### Mac (macOS)
1. Download the font `.ttf` files from the links above.
2. Double-click the downloaded files and click **Install Font**.
3. Open your Terminal (or iTerm2) preferences.
4. Go to **Profiles > Text > Font** and change it to the installed Nerd Font.

### Windows (WSL / Windows Terminal)
1. Download the font `.ttf` files and install them on Windows (Right-click -> Install).
2. Open Windows Terminal settings (`Ctrl + ,`).
3. Select your WSL/Ubuntu profile on the left.
4. Go to **Appearance > Font face** and select the installed Nerd Font. Save changes.

### Linux
1. Download the font `.ttf` files.
2. Move them to your local fonts directory: `mv *.ttf ~/.local/share/fonts/`
3. Rebuild the font cache: `fc-cache -fv`
4. Set the font in your terminal emulator's preferences.

---

## ⚡ Installation

Once your Nerd Font is installed and set in your terminal, run this single command to bootstrap your environment:

```bash
curl -sL [https://raw.githubusercontent.com/SenudaJK/OmniTerm/refs/heads/main/install.sh](https://raw.githubusercontent.com/SenudaJK/OmniTerm/refs/heads/main/install.sh) | bash