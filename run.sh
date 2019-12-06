docker run \
    --gpus all \
    -v `pwd`/src:/src  \
    --rm \
    -p 11311:11311 -p 9090:9090 -p 5900:5900 -p 6080:6080 \
    veggiebenz/pybulletsim:v1 &

dockerpid=$!
echo "docker container pid is $dockerpid"

sleep 5

xdg-open http://localhost:6080/vnc_auto.html &
#xdg-open http://localhost:9090 &

trap "kill $dockerpid" SIGINT

wait
