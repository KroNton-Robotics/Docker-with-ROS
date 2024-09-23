
xhost local:root


XAUTH=/tmp/.docker.xauth
docker rm ros2_humble_cont

docker run -it \
    --name=ros2_humble_cont \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --net=host \
    --privileged \
    -v ~/ros2_ws/:/ros2_ws/ \
    osrf/ros:humble-desktop-full \
    bash

echo "Done."
