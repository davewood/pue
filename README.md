# Docker

`docker build -t pue .`

`docker run --name pue -p 8080:8080 --detach pue`

# INSTALLATION

## frontend

install javascript dependencies

`npm install`

build static files and copy them to backend/static

`npm run build`

## backend

install perl dependencies

`carton install`

create sqlite DB

`sqlite3 pue.db < pue.sql`

start webserver

`carton exec bin/pue.pl`

visit localhost:8080/index.html in your browser.


# DEVELOPMENT

## frontend

run live-reloading webserver

`npm run serve`

## backend

generate perl schema classes

`dbicdump -o dump_directory=./lib Pue::Schema 'dbi:SQLite:./pue.db'`

start webserver

`carton exec bin/pue.pl`

visit localhost:8081 in your browser.
