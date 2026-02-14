#!/bin/bash

# ==========================================
#        MR LAZY ULTIMATE TOOL v2
# ==========================================

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
C='\033[1;36m'
W='\033[1;37m'
N='\033[0m'

LOCK_FILE="$HOME/.mrlazy_lock"
CONFIG_FILE="$HOME/.mrlazy_config"

# ---------------- Load Config ----------------
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    BANNER_NAME="MR LAZY"
fi

save_config() {
    echo "BANNER_NAME=\"$BANNER_NAME\"" > "$CONFIG_FILE"
}

# ---------------- Banner ----------------
banner() {
    clear
    echo -e "${C}"
    figlet "$BANNER_NAME"
    echo -e "${G}     MR LAZY Ultimate Hacker Interface v3${N}"
    echo
}

pause(){ read -p "Press Enter to continue..."; }

# ---------------- Lock System (Safe) ----------------
create_lock(){
    echo -ne "${Y}Create Access Key: ${N}"
    read -s pass; echo
    echo "$pass" > "$LOCK_FILE"
    chmod 600 "$LOCK_FILE"
    echo -e "${G}Lock Enabled.${N}"
    pause
}

remove_lock(){
    rm -f "$LOCK_FILE"
    echo -e "${R}Lock Removed.${N}"
    pause
}

check_lock(){
    if [ -f "$LOCK_FILE" ]; then
        echo -ne "${R}Enter Access Key: ${N}"
        read -s input; echo
        saved=$(cat "$LOCK_FILE")
        if [ "$input" != "$saved" ]; then
            echo -e "${R}Access Denied.${N}"
            exit
        fi
    fi
}

# ---------------- Necessary Setup ----------------
necessary_setup(){
    pkg update -y && pkg upgrade -y
    pkg install -y git zsh curl wget figlet toilet ruby exa
    gem install lolcat
    echo -e "${G}Necessary Setup Completed.${N}"
    pause
}

# ---------------- Zsh Setup ----------------
zsh_setup(){
    pkg install -y zsh git
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
        cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    fi
    echo -e "${G}Zsh Setup Completed.${N}"
    pause
}

enable_zsh(){
    chsh -s zsh
    echo -e "${G}Zsh Enabled.${N}"
    pause
}

enable_bash(){
    chsh -s bash
    echo -e "${G}Bash Enabled.${N}"
    pause
}

# ---------------- Zsh Banner ----------------
zsh_banner(){
    echo 'figlet MR_LAZY | lolcat' >> ~/.zshrc
    echo -e "${G}Banner Added to Zsh.${N}"
    pause
}

# ---------------- Zsh Theme ----------------
zsh_theme(){
    sed -i 's/ZSH_THEME=.*/ZSH_THEME="agnoster"/' ~/.zshrc
    echo -e "${G}Theme Set to agnoster.${N}"
    pause
}

# ---------------- Highlight / Autosuggest ----------------
highlight_autosuggest(){
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions 2>/dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting 2>/dev/null

    echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

    echo -e "${G}Autosuggestion & Highlight Enabled.${N}"
    pause
}

# ---------------- Update Tool ----------------
update_tool(){
    cd ~
    rm -rf MR-LAZY-ULTIMATE
    git clone https://github.com/example/MR-LAZY-ULTIMATE.git
    echo -e "${G}Tool Updated (Demo URL).${N}"
    pause
}

# ---------------- Change Banner Name ----------------
change_banner(){
    echo -ne "${Y}Enter New Banner Name: ${N}"
    read newname
    BANNER_NAME="$newname"
    save_config
    echo -e "${G}Banner Updated.${N}"
    pause
}

# ---------------- Menu ----------------
menu(){
while true; do
banner
echo -e "${C}[01]${G} Necessary Setup"
echo -e "${C}[02]${G} Zsh Setup"
echo -e "${C}[03]${G} Enable Zsh Shell"
echo -e "${C}[04]${G} Enable Bash Shell"
echo -e "${C}[05]${Y} Zsh Banner"
echo -e "${C}[06]${Y} Zsh Theme"
echo -e "${C}[07]${Y} Highlight / AutoSuggest"
echo -e "${C}[08]${B} Create Lock"
echo -e "${C}[09]${R} Remove Lock"
echo -e "${C}[10]${W} Update Tool"
echo -e "${C}[11]${B} Change Banner Name"
echo -e "${C}[00]${R} Exit"
echo
read -p "Select Option: " opt

case $opt in
1|01) necessary_setup ;;
2|02) zsh_setup ;;
3|03) enable_zsh ;;
4|04) enable_bash ;;
5|05) zsh_banner ;;
6|06) zsh_theme ;;
7|07) highlight_autosuggest ;;
8|08) create_lock ;;
9|09) remove_lock ;;
10) update_tool ;;
11) change_banner ;;
0|00) exit ;;
*) echo -e "${R}Invalid Option${N}"; sleep 1 ;;
esac
done
}

check_lock
menu
