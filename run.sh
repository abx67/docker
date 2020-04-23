#!/usr/bin/env bash
: ${DISPLAY:=:0}
: ${TAG:=latest}
: ${COUNTRY:=China}
: ${REPO_URL:=shanghai.azurecr.cn/runtime_ubuntu}
if [ "$COUNTRY" == "US" ]
then
    export REPO_URL=460427586040.dkr.ecr.us-west-2.amazonaws.com/autonomy/runtime_ubuntu
fi
: ${REPO_TAG:=$REPO_URL:$TAG}
nvidia-docker run -itd --rm \
--privileged \
-e DISPLAY=$DISPLAY \
-e VEHICLE_ID=$VEHICLE_ID \
-v $(dirname $(realpath ${BASH_SOURCE[0]}))/../data/perception/camera/weights:/work/data/perception/camera/weights \
-v $(dirname $(realpath ${BASH_SOURCE[0]}))/../HDMapData:/work/HDMapData \
-v /tmp:/tmp \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev:/dev \
-v /media:/media \
-v /etc/localtime:/etc/localtime:ro \
-v /mnt:/mnt:rw \
-v /run/user/1000/pulse:/run/user/1000/pulse \
-e PULSE_SERVER=unix:/run/user/1000/pulse/native \
--device /dev/snd \
--net host \
--shm-size 2G \
--pid=host \
${REPO_TAG} $@
