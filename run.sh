#!/bin/bash

localdir=${PWD##*/}  

gpuoptions=''

if [ -x "$(command -v nvidia-smi)" ]; then
  echo 'Info: nvidia-smi is executable, assume CUDA GPU installed.' >&2
  gpuoptions=' --gpus all '
fi

docker run $gpuoptions \
    -v `pwd`/code:/home/ubuntu  \
    --rm \
    -p 11311:11311 -p 9090:9090 -p 5900:5900 -p 6080:6080 \
    veggiebenz/$localdir:v1 &

dockerpid=$!
echo "docker container pid is $dockerpid"

sleep 5


if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    open http://localhost:6080/vnc_auto.html
    osascript -e 'tell app "Terminal"
        do script "docker exec -it `docker ps --format \"{{.Names}}\"` \"bash\" "
    end tell'

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # open browser to web based vnc client
    xdg-open http://localhost:6080/vnc_auto.html &

    # pop a new terminal tab connected to the docker instance
    gnome-terminal --tab --title="DOCKER" -- bash -c 'docker exec -it `docker ps --format "{{.Names}}"` /bin/bash ; $SHELL '
fi

trap "kill $dockerpid" INT

wait
