# Docker

`docker-compose build`

`docker-compose up`

http://localhost:8080/index.html

# Development

## enter docker container
`docker exec -i -t pue /bin/bash`

## start hot reloading dev server
`cd frontend`

`npm run serve`

127.0.0.1:8081

## re-generate perl schema classes
`dbicdump -o dump_directory=./lib Pue::Schema 'dbi:SQLite:./pue.db'`
