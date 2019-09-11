#!/bin/sh

{

set -e

printf "setup frontend\n"
cd ~/pue_app/frontend
npm install

printf "setup backend\n"
cd ~/pue_app/backend
carton install

until PGSERVICE=pue psql -c '\q'; do
    printf "Postgres is unavailable - sleeping\n"
    sleep 1
done

printf "Postgres is up - check version\n"

set +e
dbcheck=`PGSERVICE=pue psql -c 'SELECT id FROM usr LIMIT 1' 2>&1`
set -e

if [[ $dbcheck = *'relation "usr" does not exist'* ]]; then
    printf "init DB\n"
    PGSERVICE=pue psql --single-transaction --file=sql/pue.sql
    #yes | carton exec bin/db/apply_changes.pl
    #carton exec bin/db/fixtures.pl
else
    printf "apply DB changes\n"
    #yes | carton exec bin/db/apply_changes.pl
fi

printf "\n\n"
printf "######################\n"
printf "### setup finished ###\n"
printf "######################\n\n"

printf "### run this command to start the backend service\n"
printf "docker exec -it pue-app bash -c 'cd ~/pue_app/backend && carton exec bin/pue.pl'\n\n"

printf "### run this command to start the frontend service\n"
printf "docker exec -it pue-app bash -c 'cd ~/pue_app/frontend && npm run serve'\n\n"

tail -f /dev/null

} >&2 # redirect stout to stderr
