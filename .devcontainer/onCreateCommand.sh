# executed once after container had been build, before it is started

WORKSPACE_DIR="$(pwd)"

# install packages
sudo apt-get update
sudo apt install -y wmctrl

# download and install filius
cd /tmp
curl -o filius.deb https://www.lernsoftware-filius.de/downloads/Setup/filius_latest_all.deb
sudo apt install -y ./filius.deb
rm filius.deb
sudo sed -i 's/# locale=en_GB/locale=en_GB/' /etc/filius/filius.ini # set language of Filius
cd "$WORKSPACE_DIR"

# configure novnc
sudo cp -f "$WORKSPACE_DIR/.devcontainer/noVNC_index.html" /usr/local/novnc/noVNC-*/index.html

