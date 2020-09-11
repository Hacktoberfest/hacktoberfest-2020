#!/bin/sh

# script/setup: Set up application for the first time after cloning, or set it
#               back to the initial first unused state.

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "==> Setting up DB…"
# reset database to a fresh state.
bundle exec rake db:setup

echo "==> Hacktoberfest is now ready to go!"

bundle exec rails s -b 0.0.0.0
