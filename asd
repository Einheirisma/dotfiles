sudo -i
usermod -a -G wheel USERNAME
nvim /etc/sudoers
###########################################################################
## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL:ALL) ALL
###########################################################################
logout
nmtui
mkdir -p ~/.config/X11 ~/.cache/bash/ ~/.downloads ~/.pictures
git clone https://github.com/Einheirisma/dotfiles.git
mv ~/dotfiles/bash/ \
    ~/dotfiles/blesh/ \
    ~/dotfiles/mpv/ \
    ~/dotfiles/nvim/ \
    ~/.config/
sudo nvim /etc/bash.bashrc
###########################################################################
if [ -d /etc/bash/bashrc.d/ ]; then
    for f in /etc/bash/bashrc.d/*.sh; do
        [ -r "$f" ] && . "$f"
    done
    unset f
fi

if [ -s "${XDG_CONFIG_HOME:-$HOME/.config}/bash/.bash_profile" ]; then
    . "${XDG_CONFIG_HOME:-$HOME/.config}/bash/.bash_profile"
fi
###########################################################################
source ~/.config/bash/.bash_profile
rm ~/.bash_profile ~/.bashrc ~/.bash_logout
mv ~/.bash_history $XDG_CACHE_HOME/bash/bash_history
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo nvim /etc/pacman.conf
###########################################################################
Color
ILoveCandy
CheckSpace
VerbosePkgLists
ParallelDownloads = 10
[multilib]
Include = /etc/pacman.d/mirrorlist
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
###########################################################################
sudo pacman -Syyu

sudo pacman -S go \
    npm \
    rustup \
    python \
    reflector

sudo reflector \
  --verbose \
  --country 'RU,KZ,BY,TR,FI,PL,DE,NL' \
  --protocol http \
  --protocol https \
  --latest 30 \
  --fastest 10 \
  --sort rate \
  --age 12 \
  --threads 20 \
  --download-timeout 5 \
  --save /etc/pacman.d/mirrorlist
go telemetry off
rm -rf ~/.config/go
rustup default stable

sudo pacman -S \
fd \
jq \
feh \
bat \
fzf \
git \
tar \
zip \
eza \
mpv \
tmux \
base \
btop \
curl \
wget \
mesa \
7zip \
xclip \
go-yq \
rsync \
unzip \
unrar \
neovim \
man-db \
libxft \
libx11 \
openssh \
nautilus \
parallel \
nwg-look \
man-pages \
linux-lts \
blesh-git \
xdg-utils \
base-devel \
noto-fonts \
xorg-xinit \
xorg-server \
apple-fonts \
ripgrep-all \
libva-utils \
qutebrowser \
libxinerama \
imagemagick \
brightnessctl \
vulkan-radeon \
linux-firmware \
pacman-contrib \
noto-fonts-cjk \
noto-fonts-emoji \
otf-font-awesome \
vulkan-icd-loader \
linux-lts-headers \
libva-mesa-driver \
archlinux-keyring

timedatectl set-ntp true
sudo mkdir /etc/pacman.d/hooks
sudo nvim /etc/pacman.d/hooks/paccache.hook
###########################################################################
[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache...
When = PostTransaction
Exec = /usr/bin/paccache -rk 2
###########################################################################

git clone https://aur.archlinux.org/paru.git ~/.paru
cd .paru
makepkg -rsi
cd .. && rm -rf ~/.paru

paru -S \
    ttf-joypixels \
    macos-tahoe-cursor \
    ayugram-desktop-bin

sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
sudo nvim /etc/xdg/user-dirs.conf
###########################################################################
enabled=False
###########################################################################
sudo grub-mkconfig -o /boot/grub/grub.cfg

git clone https://github.com/vinceliuice/Colloid-icon-theme.git --depth=1 ~/.colloid-icon-theme
~/.colloid-icon-theme/install.sh --scheme default --theme default --bold

git clone https://github.com/vinceliuice/MacTahoe-gtk-theme.git --depth=1 ~/.mactahoe-gtk-theme
~/.mactahoe-gtk-theme/install.sh --dest $HOME/.local/share/themes --opacity normal --color dark --alt normal --theme default --scheme standard --highdefinition --round --darker

curl -L -o tx-02-berkeley-mono-pass=SCT.7z \
     https://pixeldrain.com/api/file/gBNWHDr6
extract tx-02-berkeley-mono-pass\=SCT.7z
###########################################################################
SCT
###########################################################################
mv TX-02/ ~/.local/share/fonts
rm -rf ~/tx-02-berkeley-mono-pass=SCT.7z ~/TX-02 ~/.colloid-icon-theme ~/.mactahoe-gtk-theme
fc-cache -f -v

git clone https://git.suckless.org/dwm $XDG_CONFIG_HOME/dwm
cd $XDG_CONFIG_HOME/dwm
make
sudo make clean install
cd ~

git clone https://git.suckless.org/st $XDG_CONFIG_HOME/st
cd $XDG_CONFIG_HOME/st
make
sudo make clean install
cd ~

git clone https://git.suckless.org/dmenu $XDG_CONFIG_HOME/dmenu
cd $XDG_CONFIG_HOME/dmenu
make
sudo make clean install
cd ~

git clone https://git.suckless.org/slstatus $XDG_CONFIG_HOME/slstatus
cd $XDG_CONFIG_HOME/slstatus
make
sudo make clean install
cd ~

nvim $XDG_CONFIG_HOME/X11/xinitrc
###########################################################################
exec dwm
###########################################################################

ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh-keyscan github.com >> ~/.ssh/known_hosts
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
bat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
