# training_docker

http://localhost:8123/slides.md#/

```bash
docker network inspect bridge --format='{{json .IPAM.Config }}' | jq .[].Gateway
```
