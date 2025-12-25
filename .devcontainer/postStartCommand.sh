# executed each time the container is (re)started
# commands should terminate, use nohup otherwise

WORKSPACE_DIR="$(pwd)"

# set language of Filius
sudo sed -i 's/# locale=en_GB/locale=en_GB/' /etc/filius/filius.ini 

# link 'filius bestanden'
ln -sf "${WORKSPACE_DIR}/filius-bestanden" '/home/codespace/filius-bestanden'

# wait for DISPLAY to start
until xdpyinfo -display "${DISPLAY:-:1}"; do 
  echo "Waiting untill X display has started"
  sleep 1
done

# start filius and leave it running in background
cd "${WORKSPACE_DIR}/filius-bestanden"
nohup bash -c 'filius > ../.devcontainer/.nohup_filius.out 2>&1 & rm nohup.out &'

# wait for FILIUS window
until wmctrl -l| grep -q FILIUS ; do 
  echo "wait for FILIUS window"
  sleep 1 
done

# maximize filius window
wmctrl -r 'FILIUS' -b add,maximized_horz,maximized_vert
