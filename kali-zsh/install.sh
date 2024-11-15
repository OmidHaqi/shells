#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

install_packages() {
    if [ -x "$(command -v apt)" ]; then
        
        echo -e "${GREEN}Detected apt package manager. Installing packages...${NC}"
        sudo apt update > /dev/null 2>&1 || { echo -e "${RED}Error updating package lists with apt.${NC}"; exit 1; }
        sudo apt install -y zsh zsh-syntax-highlighting zsh-autosuggestions gnome-tweaks > /dev/null 2>&1 || { echo -e "${RED}Error installing packages with apt.${NC}"; exit 1; }
        
        elif [ -x "$(command -v dnf)" ]; then
        
        echo -e "${GREEN}Detected dnf package manager. Installing packages...${NC}"
        sudo dnf install -y zsh zsh-syntax-highlighting zsh-autosuggestions gnome-tweaks > /dev/null 2>&1 || { echo -e "${RED}Error installing packages with dnf.${NC}"; exit 1; }
        
        elif [ -x "$(command -v yum)" ]; then
        echo -e "${GREEN}Detected yum package manager. Installing packages...${NC}"
        sudo yum install -y zsh zsh-syntax-highlighting zsh-autosuggestions gnome-tweaks > /dev/null 2>&1 || { echo -e "${RED}Error installing packages with yum.${NC}"; exit 1; }
        elif [ -x "$(command -v pacman)" ]; then
        
        echo -e "${GREEN}Detected pacman package manager. Installing packages...${NC}"
        sudo pacman -Sy --noconfirm zsh gnome-tweaks > /dev/null 2>&1 || { echo -e "${RED}Error installing packages with pacman.${NC}"; exit 1; }
        
        if ! pacman -Qs zsh-syntax-highlighting > /dev/null; then
            
            echo -e "${GREEN}Installing zsh-syntax-highlighting from AUR...${NC}"
            install_aur_helper || { echo -e "${RED}Error installing zsh-syntax-highlighting from AUR.${NC}"; exit 1; }
            yay -S --noconfirm zsh-syntax-highlighting > /dev/null 2>&1 || { echo -e "${RED}Error installing zsh-syntax-highlighting with yay.${NC}"; exit 1; }
            
        fi
        if ! pacman -Qs zsh-autosuggestions > /dev/null; then
            
            echo -e "${GREEN}Installing zsh-autosuggestions from AUR...${NC}"
            install_aur_helper || { echo -e "${RED}Error installing zsh-autosuggestions from AUR.${NC}"; exit 1; }
            yay -S --noconfirm zsh-autosuggestions > /dev/null 2>&1 || { echo -e "${RED}Error installing zsh-autosuggestions with yay.${NC}"; exit 1; }
            
        fi
        
    else
        echo -e "${RED}No supported package manager found. Please install the required packages manually.${NC}"
        exit 1
    fi
}
install_aur_helper() {
    if ! command -v yay > /dev/null; then
        
        echo -e "${GREEN}Installing yay (AUR helper)...${NC}"
        git clone https://aur.archlinux.org/yay.git > /dev/null 2>&1 || { echo -e "${RED}Error cloning yay repository.${NC}"; exit 1; }
        cd yay || { echo -e "${RED}Failed to enter yay directory.${NC}"; exit 1; }
        makepkg -si --noconfirm > /dev/null 2>&1 || { echo -e "${RED}Error installing yay.${NC}"; exit 1; }
        cd ..
        rm -rf yay
    fi
}
change_default_shells() {
    
    echo -e "${GREEN}Changing default shell to Zsh for current user...${NC}"
    
    if chsh -s /bin/zsh > /dev/null 2>&1; then
        echo -e "${GREEN}Default shell changed to Zsh for the current user.${NC}"
    else
        echo -e "${RED}Failed to change default shell for the current user.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}Changing default shell to Zsh for root user...${NC}"
    
    if sudo chsh -s /bin/zsh root > /dev/null 2>&1; then
        
        echo -e "${GREEN}Default shell changed to Zsh for root user.${NC}"
        
    else
        
        echo -e "${RED}Failed to change default shell for root user.${NC}"
        exit 1
        
    fi
}
configure_zshrc() {
    
    echo -e "${GREEN}Configuring .zshrc file...${NC}"
    rm -f ~/.zshrc > /dev/null 2>&1 || { echo -e "${RED}Error removing existing .zshrc file.${NC}"; exit 1; }
    cp -rf .zshrc ~ > /dev/null 2>&1 || { echo -e "${RED}Error copying .zshrc file.${NC}"; exit 1; }
    source ~/.zshrc > /dev/null 2>&1 || { echo -e "${RED}Error sourcing .zshrc file.${NC}"; exit 1; }
    
}
ask_restart() {
    
    echo -e "${GREEN}Installation and configuration completed successfully. Zsh is now the default shell for both the current user and root.${NC}"
    read -p "Do you want to restart the system now? [y/N]: " choice
    case "$choice" in
        [yY]|[yY][eE][sS])
            echo -e "${GREEN}Rebooting the system...${NC}"
            sudo reboot
        ;;
        *)
            echo -e "${GREEN}Please restart your system manually to apply changes.${NC}"
        ;;
    esac
}

install_packages
change_default_shells
configure_zshrc
ask_restart
