#!/bin/bash

# Exit on error
# set -e

# Rust packages
# cargo install shellharden cargo-update trashy rustpython

# Python packages
# pipx install flake8 pynvim ytmdl stig pywal aider-chat tqdm

# Build apps
mkdir -p ~/Applications && cd ~/Applications

# ytfzf
git clone https://github.com/pystardust/ytfzf
cd ytfzf && sudo make install doc
cd ..

# Czmod
git clone https://github.com/skywind3000/czmod.git
cd czmod && sh build.sh
cd ..

# Koi
# git clone https://github.com/baduhai/Koi.git
# cmake -S "./Koi/src/" -B "./Koi/src/build/"
# sudo make -C "./Koi/src/build/"
# sudo make -C "./Koi/src/build/" install

# Flatpak apps
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.standardnotes.standardnotes \
    net.ankiweb.Anki \
    org.onlyoffice.desktopeditors \
    com.github.tchx84.Flatseal \
    org.telegram.desktop \
    us.zoom.Zoom \
    org.getmonero.Monero \
    io.gitlab.librewolf-community \
    com.spotify.Client \
    com.mastermindzh.tidal-hifi \
    com.logseq.Logseq \
    com.google.Chrome

# Additional scripts
curl -f https://zed.dev/install.sh | sh
bash <(curl -sSL https://spotx-official.github.io/run.sh)
