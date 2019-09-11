## build image
```
docker-compose build --build-arg CONTAINER_UID=`id -u` app
docker-compose up
```

http://localhost:8080/index.html

## enter app container
`docker exec -it pue-app /bin/bash`
