dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf copr enable varlad/onefetch -y

dnf install neovim yt-dlp python3-pip latte-dock zsh kitty neofetch brightnessctl \
  kvantum cargo mpv ranger bismuth calibre kolourpaint kcolorchooser trash-cli neofetch picard \
  gsettings-desktop-schemas gsettings-qt qt5ct lxappearance megatools qt5-qtstyleplugins \
  timeshift power-profiles-daemon git-core musl-gcc harfbuzz cheat fzf \
  ripgrep bat htop ktouch ffmpeg ffmpegthumbnailer python3-bpython xonsh \
  black qalculate perl-Image-ExifTool fd-find odt2txt dash onefetch python3-jupyter-core python3-notebook \
  aria2 lsd gnome-settings-daemon httrack svt-av1 wget2 touchegg nvtop transmission-qt npm \
  torbrowser-launcher tldr git syncthing gh -y

# VSCodium
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo 
dnf install codium

# Neomutt :
# dnf copr enable flatcap/neomutt -y
# dnf install neomutt pass msmtp isync -y

# Wayland Dependend
# dnf install slurp rofi-wayland clipman wtype wl-clipboard -y

# X11 Dependend
# dnf install picom xclip xdotool -y

# Touch Screen
dnf install onboard -y

# Nvidia
dnf install gwe mate-optimus -y
dnf install akmod-nvidia -y
dnf install xorg-x11-drv-nvidia-cuda -y
dnf copr enable sunwire/envycontrol - y
sudo dnf install python3-envycontrol - y
sudo systemctl enable nvidia-{suspend,resume,hibernate}
sudo ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

# For gaming
dnf install wine winetricks wine-mono lutris -y

# Codecs
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin --allowerasing
dnf groupupdate sound-and-video

# pyenv dependecies
# dnf install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel -y

#Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo -y
sudo dnf install -y docker-ce docker-ce-cli containerd.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker samdc

# Remove Bloat
# dnf remove krfb akregator elisa-player krdc krdc-libs kmines dnfdragora kmines kruler kmahjongg kmag konsole5-part konsole5-part plasma-discover -y
