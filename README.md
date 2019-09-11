## build image
```
docker-compose build --build-arg CONTAINER_UID=`id -u` app
docker-compose up
```

## start backend and frontend
```
docker exec -it pue-app bash -c "cd ~/pue_app/backend && carton exec bin/pue_app.pl"
docker exec -it pue-app bash -c "cd ~/pue_app/frontend && npm run serve"
```

http://localhost:8080/index.html

## enter app container
`docker exec -it pue-app /bin/bash`
