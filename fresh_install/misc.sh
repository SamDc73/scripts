#Auto start mpd
# systemctl --user start mpd && systemctl --user enable mpd

# X11 Config
# sudo echo "picom --experimental-backends&" &>> /etc/profile 

# Change shell to zsh
chsh -s /bin/zsh

# update tldr man pages
tldr --update

# TO have flatpak theming on flatpak pakages
sudo flatpak override --filesystem="$HOME"/.local/share/themes

# change swappiness
echo "vm.swappiness=25" | sudo tee -a /etc/sysctl.conf
# sudo sysctl -w vm.swappiness=25

# Link sh to dash
sudo ln -sfT /bin/dash /bin/sh

# Fedora only
#dnf config
echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
echo "fastestmirror=True" | suod tee -a /etc/dnf/dnf.conf

# KDE Connect
# sudo firewall-cmd --permanent --zone=public --add-service=kdeconnect
# sudo firewall-cmd --reload
