# DB

## create sqlite DB
sqlite3 pue.db < pue.sql

## generate perl schema classes
dbicdump -o dump_directory=./lib Pue::Schema 'dbi:SQLite:./pue.db'
