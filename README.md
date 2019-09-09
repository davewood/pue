# Docker

```
docker-compose build --build-arg CONTAINER_UID=`id -u` app
docker-compose up
```

http://localhost:8080/index.html

# Development

## enter docker container
`docker exec -it pue-app /bin/bash`

echo 'run `docker exec -it pue-app bash -c "cd ~/pue_app/backend && carton exec bin/pue_app.pl"`'
echo 'run `docker exec -it pue-app bash -c "cd ~/pue_app/frontend && npm run serve"`'
tail -f /dev/null
