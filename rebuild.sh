#!/bin/bash
DOCKER_USERNAME=${1-testuser}
#get your user id
#CURRENT_USER_UID=$(id | awk '{split( $1, arr, "="); split(arr[2], arr2, "("); print arr2[1]}')
DOCKER_USER_UID=${1-1001}

docker stop container_firefox
docker rm container_firefox
docker image rm ubuntu_firefox

echo "building docker with user ${DOCKER_USERNAME} and uid ${DOCKER_USER_UID}"

docker build -t ubuntu_firefox --build-arg="DOCKER_USERNAME=${DOCKER_USERNAME}" --build-arg="DOCKER_USER_UID=${DOCKER_USER_UID}"  ${0%/*}

#Store last rebuild variables to be used in run.sh
echo -e "#!/bin/bash\nDOCKER_USERNAME=${DOCKER_USERNAME}\nDOCKER_USER_UID=${DOCKER_USER_UID}"
