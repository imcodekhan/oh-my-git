# Oh-My-Git 🚀

> Supercharge your Git workflow with intuitive commands and powerful shortcuts.

Oh-My-Git transforms your Git experience with a lightweight, customizable wrapper that makes version control more natural and efficient.

## ✨ Features

- **Lightning Fast**: Execute Git commands with the simple `omg` shorthand
- **Shell Agnostic**: Seamless integration with Bash and Zsh
- **Fully Customizable**: Tailor commands to your workflow
- **Developer Friendly**: Intuitive aliases for common Git operations

## 🚀 Quick Start

**One-Line Install (Recommended)**
```bash
curl -sSL https://raw.githubusercontent.com/imcodekhan/oh-my-git/master/install.sh | bash
```

**Manual Setup**
```bash
# Clone repository
git clone https://github.com/imcodekhan/oh-my-git.git ~/.oh-my-git

# Add to shell config (choose one)
echo 'source ~/.oh-my-git/oh-my-git.sh' >> ~/.bashrc
echo 'source ~/.oh-my-git/oh-my-git.sh' >> ~/.zshrc

# Add alias
echo 'alias omg="oh-my-git"' >> ~/.bashrc  # or .zshrc

# Reload shell
source ~/.bashrc  # or source ~/.zshrc
```

## 💡 Usage

Start using Oh-My-Git immediately with the `omg` command:

```bash
omg status    # Check repository status
omg push      # Push changes
omg sync      # Sync with remote
```

## 🛠 Customization

Edit `~/.oh-my-git/oh-my-git.sh` to add custom commands and aliases:

```bash
# Example custom command
function git_publish() {
    git add .
    git commit -m "$1"
    git push
}
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing`)
5. Open a Pull Request

## 📝 License

[MIT License](LICENSE) - Feel free to use and modify!

## 📞 Contact

Issues or questions? [Open an issue](https://github.com/imcodekhan/oh-my-git/issues) or reach out directly.

---
Made with ❤️ by developers, for developers