#!/bin/sh

# script/setup: Set up application for the first time after cloning, or set it
#               back to the initial first unused state.

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "==> Setting up DB…"
# reset database to a fresh state.
# Change this for docc
bundle exec rake db:create
bundle exec rake db:migrate

# Compile assets
bundle exec rake assets:precompile

echo "==> Hacktoberfest is now ready to go!"

# Adding ENV in here for docc first pass test in staging
bundle exec puma -C config/puma.rb 