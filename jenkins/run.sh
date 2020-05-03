#!/bin/bash -x

if [ -S ${DOCKER_SOCKET} ]; then
    DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
    sudo groupadd -for -g ${DOCKER_GID} ${DOCKER_GROUP}
    sudo usermod -aG ${DOCKER_GROUP} ${JENKINS_USER}
    sudo chmod 777 /var/run/docker.sock
fi

exec sudo -E -H -u jenkins bash -c /usr/local/bin/jenkins.sh