# executed each time the container is (re)started
# commands should terminate, use nohup otherwise

# set language of Filius
sudo sed -i 's/# locale=en_GB/locale=en_GB/' /etc/filius/filius.ini 

# link 'filius bestanden'
ln -sf "${workspaceFolder}/filius bestanden" '/home/codespace/filius bestanden'

# wait for GUI to start, to prevent error from filius that is can't connect to display
until xdpyinfo -display "${DISPLAY:-:1}"; do
  echo "Waiting untill X display has started"
  sleep 0.5
done

# start filius and leave it running in background
cd "{workspaceFolder}/.devcontainer"
nohup bash -c 'filius > .nohup_filius.out 2>&1 & rm nohup.out &'

# wait for FILIUS window
while ! wmctrl -l| grep -q FILIUS ; do sleep 1; echo "wait for FILIUS window"; done

# maximize filius window
wmctrl -r 'FILIUS' -b add,maximized_horz,maximized_vert
