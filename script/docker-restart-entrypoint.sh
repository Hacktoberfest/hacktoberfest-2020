#!/bin/sh

# Restart application and run migrations Comment out migrations if you don't want them.

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "==> Migrating…"
# reset database to a fresh state.
bundle exec rake db:migrate

echo "==> Hacktoberfest is now ready to go!"

bundle exec rails s -b 0.0.0.0
