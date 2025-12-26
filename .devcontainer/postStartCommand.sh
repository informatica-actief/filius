# executed each time the container is (re)started
# commands should terminate, use nohup otherwise
# script is started from workspace folder (i.e. workspace/filius)

# wait for DISPLAY to start
until xdpyinfo -display "${DISPLAY:-:1}" | head -5; do 
  echo "Waiting untill X display has started"
  sleep 1
done

# start filius and leave it running in background
nohup bash -c 'filius > .devcontainer/.nohup_filius.out 2>&1 & rm nohup.out &'

# wait for FILIUS window
until wmctrl -l| grep -q FILIUS ; do 
  echo "wait for FILIUS window"
  sleep 1 
done

# maximize filius window
wmctrl -r 'FILIUS' -b add,maximized_horz,maximized_vert
