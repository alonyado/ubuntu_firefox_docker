#!/bin/bash
source ${0%/*}/env.sh
NEED_REMOVE=$(docker ps -a | grep container_firefox | wc -l)

OVERRIDE=${1-0}
if [ $NEED_REMOVE -gt 0 ] && [ $OVERRIDE -gt 0 ]; then
	echo "remove old container"
	docker stop container_firefox
	sleep 3
	NEED_REMOVE=$(docker ps -a | grep container_firefox | wc -l)
	if [ $NEED_REMOVE -gt 0 ]; then
		docker rm container_firefox
	fi
else
	echo "container exists"
fi

if [ $NEED_REMOVE -lt 1 ]; then
	docker run -dit --name container_firefox --env DISPLAY=unix$DISPLAY -v ${XAUTHORITY}:/home/${DOCKER_USERNAME}/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix  --rm -u ${DOCKER_USER_UID}:${DOCKER_USER_UID} ubuntu_firefox /bin/bash
fi

#For debuging, get inside docker
#docker exec -it container_firefox /bin/bash

#Allow access screen from other user
xhost +local:

docker exec -it container_firefox firefox

#Finished usage, disallow access screen from other user
xhost -SI:localuser:nolim


