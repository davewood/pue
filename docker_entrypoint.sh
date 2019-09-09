#!/bin/sh

{

set -e

echo "setup frontend"
cd ~/pue_app/frontend
npm install

echo "setup backend"
cd ~/pue_app/backend
carton install

until PGSERVICE=pue psql -c '\q'; do
    echo "Postgres is unavailable - sleeping"
    sleep 1
done

echo "Postgres is up - check version"

set +e
dbcheck=`PGSERVICE=pue psql -c 'SELECT id FROM usr LIMIT 1' 2>&1`
set -e

if [[ $dbcheck = *'relation "usr" does not exist'* ]]; then
    echo 'init DB'
    PGSERVICE=pue psql --single-transaction --file=sql/pue.sql
    #yes | carton exec bin/db/apply_changes.pl
    #carton exec bin/db/fixtures.pl
else
    echo 'apply DB changes'
    #yes | carton exec bin/db/apply_changes.pl
fi

echo 'run `docker exec -it pue-app bash -c "cd ~/pue_app/backend && carton exec bin/pue.pl"`'
echo 'run `docker exec -it pue-app bash -c "cd ~/pue_app/frontend && npm run serve"`'
tail -f /dev/null

} >&2 # redirect stout to stderr
