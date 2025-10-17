#!/bin/bash

#References: https://qiita.com/polarbear08/items/931fe04ec228fad13092
docker run \
    --detach \
    --publish 9000:9000 \
    --publish 8000:8000 \
    --name portainer \
    --restart always \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume portainer_data:/data \
    portainer/portainer-ce

