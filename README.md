# training_docker

http://localhost:8123/slides.md#/

docker network inspect bridge --format='{{json .IPAM.Config }}' | jq .[].Gateway
