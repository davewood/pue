# INSTALLATION

## frontend
npm install
npm run build

## backend

### create sqlite DB
sqlite3 pue.db < pue.sql
perl bin/pue.pl


# DEVELOPMENT

## frontend
npm run serve

## backend

### generate perl schema classes
dbicdump -o dump_directory=./lib Pue::Schema 'dbi:SQLite:./pue.db'

### start webserver
perl bin/pue.pl
