#!/bin/bash


# Exit on any error
set -e

# Function to check NVIDIA driver
check_nvidia() {
    echo "----------------------------------------"
    echo "Checking NVIDIA driver status..."
    if ! modinfo -F version nvidia > /dev/null 2>&1; then
        echo "⚠️  Warning: NVIDIA driver is NOT loaded!"
        echo "Please wait a few minutes for the driver to build"
        echo "You can check status with: modinfo -F version nvidia"
    else
        echo "✅ NVIDIA driver is loaded successfully!"
        echo "Driver version: $(modinfo -F version nvidia)"
    fi
    echo "----------------------------------------"
}


check_docker() {
    echo "----------------------------------------"
    echo "Checking Docker status..."
    if systemctl is-active --quiet docker; then
        echo "✅ Docker service is running"
    else
        echo "⚠️  Warning: Docker service is NOT running"
    fi

    if groups $USER | grep &>/dev/null '\bdocker\b'; then
        echo "✅ User $USER is in docker group"
    else
        echo "⚠️  Warning: User $USER is NOT in docker group"
    fi
    echo "----------------------------------------"
}


# Initial status check
check_nvidia
check_docker


# Enable non-interactive mode for dnf
echo "defaultyes=True" >> /etc/dnf/dnf.conf

# Update system first
dnf update -y

# RPM Fusion
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
               https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


# Main packages
dnf install -y neovim yt-dlp python3-pip zsh kitty neofetch  \
    kvantum cargo mpv ranger calibre kolourpaint kcolorchooser \
    gsettings-desktop-schemas gsettings-qt qt5ct lxappearance megatools qt5-qtstyleplugins \
    git-core musl-gcc harfbuzz cheat fzf \
    ripgrep bat htop ktouch ffmpeg ffmpegthumbnailer \
    fd-find dash python3-jupyter-core python3-notebook \
    aria2 lsd httrack svt-av1 wget2 touchegg transmission-qt npm \
    torbrowser-launcher tldr syncthing ytfzf pipx \
    ruff uv direnv python3-distutils-extra xclip jq curl \
    --skip-unavailable  --skip-broken


# VSCodium
rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | tee /etc/yum.repos.d/vscodium.repo
dnf install -y codium

# Mulvad
dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo --overwrite
dnf install -y mullvad-vpn

# Touch Screen
# dnf install onboard -y


# Nvidia drivers
dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan

# Nvidia drivers tools
dnf copr enable -y sunwire/envycontrol
dnf install -y python3-envycontrol nvtop gwe

# Nvidia suspend
dnf install -y xorg-x11-drv-nvidia-power
systemctl enable nvidia-{suspend,resume,hibernate}

# Enable kernel modeset for better performance
sudo grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'

# For gaming
# dnf install -y wine winetricks wine-mono lutris vulkan

# Multimedia codecs
dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin --allowerasing
dnf groupupdate -y sound-and-video
dnf install -y xorg-x11-drv-nvidia-cuda-libs nvidia-vaapi-driver libva-utils vdpauinfo #nvidia specific


#Docker
dnf install -y dnf-plugins-core
dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker
getent group docker || groupadd docker
usermod -aG docker $USER

# Remove Bloat (KDE spin)
# dnf remove -y krfb akregator elisa-player krdc krdc-libs kmines dnfdragora kmines kruler kmahjongg kmag konsole5-part konsole5-part plasma-discover


# External packages
rpm -i https://github.com/baduhai/Koi/releases/download/0.3.1/Koi-0.3.1-1--FEDORA.x86_64.rpm


# Final status check
check_nvidia
check_docker


#verify
# verify NVIDIA driver
# modinfo -F version nvidia
# Docker
# docker run hello-world
