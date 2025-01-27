# Base packages installation with pacman
sudo pacman -S --needed --noconfirm neovim yt-dlp python-pip zsh kitty neofetch \
    kvantum-qt5 cargo mpv ranger calibre kolourpaint kcolorchooser \
    gsettings-desktop-schemas qt5ct lxappearance megatools \
    git musl ripgrep fzf bat htop ktouch ffmpeg ffmpegthumbnailer \
    fd dash jupyter-notebook aria2 httrack wget transmission-qt npm \
    tor syncthing jq python-distutils-extra noto-fonts noto-fonts-emoji \
    python-ruff python-uv direnv zed code  python-pywal xclip curl \
    ytfzf lsd tldr touchegg telegram-desktop monero svt-av1


# AUR packages using yay (install yay first if not installed)
yay -S --needed --noconfirm  mullvad-vpn-bin wget2 cheat spotify  \
    yin-yang jan-bin windsurf logseq-desktop-bin anki-bin google-chrome \
    onlyoffice-bin firefox-kde-opensuse	zoom trashy 

# Nvidia drivers and tools
#sudo pacman -S --needed --noconfirm nvidia nvidia-utils nvidia-settings cuda \
#    lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader nvidia-container-toolkit

# Gaming related
sudo pacman -S --needed --noconfirm wine wine-mono winetricks lutris vulkan-tools

# Multimedia codecs
sudo pacman -S --needed --noconfirm gst-plugins-base gst-plugins-good \
    gst-plugins-bad gst-plugins-ugly gst-libav

# Docker installation
sudo pacman -S --needed --noconfirm docker docker-compose
sudo systemctl enable --now docker
getent group docker || sudo groupadd docker
sudo usermod -aG docker $USER

# Nvidia specific tools
yay -S --needed --noconfirm nvtop gwe envycontrol

# Enable kernel modeset for nvidia
# sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 /' /etc/default/grub
# sudo grub-mkconfig -o /boot/grub/grub.cfg

# KDE bloat removal (if using KDE)
sudo pacman -R krfb akregator elisa krdc kmines kmahjongg kruler kmag konsole-part discover

# Verification commands
# nvidia-smi  # Check NVIDIA driver
# docker run hello-world  # Check Docker

