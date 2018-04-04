#!/bin/bash

#TODO: add alternative images for nvidia non-nvidia in this switch:
DOCKER=docker
if [ -x "$(command -v nvidia-docker)" ]; then
    DOCKER=nvidia-docker
fi
echo "DOCKER cmd is $DOCKER"


# Need to give the container access to your windowing system
# Further reading: http://wiki.ros.org/docker/Tutorials/GUI
# and http://gernotklingler.com/blog/howto-get-hardware-accelerated-opengl-support-docker/
export DISPLAY=${DISPLAY:=":0"}
xhost +

${DOCKER} run -ti -v my_gridcoin:/root/.GridcoinResearch \
           -e DISPLAY \
           -v "/Library/Application Support/BOINC Data":/root/boinc_dir \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           --restart unless-stopped \
           -it bbarker/gridcoin-cuda:latest
