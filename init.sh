#!/bin/sh
/usr/local/pgsql/bin/createdb -h postgres --template=template0 -E UTF-8 store_db
/usr/local/pgsql/bin/createuser -h postgres store_user
/usr/local/pgsql/bin/psql -h postgres -f store_db.sql store_db
