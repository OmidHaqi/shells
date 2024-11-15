# Shells

Welcome to the **Shells** repository! 🎉

This repository is dedicated to storing shell scripts that transform and beautify your terminal environment. Each folder in this repository represents a specific shell setup, complete with all the necessary scripts and configuration files to make installation and setup as smooth as possible. This collection is perfect for anyone looking to enhance their command-line experience with visually appealing shells!

---

### Shell Setup Instructions

#### 1. Clone the Repository

```bash
git clone https://github.com/omidhaqi/shells.git
cd shells
```

#### 2. Choose Your Shell

Navigate to the directory of the shell you'd like to install. For example, to install the **Kali-ZSH**:

```bash
cd kali-zsh
```

#### 3. Run the Installation Script

Inside the chosen shell folder, there is an `install.sh` script. Simply execute it to begin the installation process.

```bash
chmod +x install.sh
./install.sh
```

The installation script will:

- Install required packages.
- Set up the shell as the default for the current user.
- Configure additional features (like syntax highlighting, autosuggestions, themes, etc.)
- Ask if you’d like to reboot the system to finalize the setup.

## Shell Profiles

### [Kali-ZSH](./kali-zsh)



**Kali-ZSH** offers a sleek, modern look with custom syntax highlighting, autosuggestions, and a beautiful prompt. The script installs and configures Zsh with additional plugins to enhance usability and appearance.

![Kali-zsh](/screenshots/kali-shell.gif)

- **Installation Command:**

```bash
chmod +x install.sh
./install.sh
```

- **Requirements:** `zsh`, `zsh-syntax-highlighting`, `zsh-autosuggestions`, and optionally `gnome-tweaks` for certain Linux distributions.

- **Reboot Required:** After installation, a system reboot is recommended to apply the shell as default fully.

---

Feel free to explore and customize the scripts in each directory to match your preferences. If you come across other shells you’d like to add, just follow the structure here, and don’t hesitate to contribute to the repository!

Happy shelling! 🚀
