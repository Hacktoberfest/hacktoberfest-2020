#!/bin/sh

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
DOCKER="/usr/local/bin/docker"
FILE="docker-compose.yml"
RESTART_FILE="docker-compose.restart.yml"

$COMPOSE stop app sidekiq && $COMPOSE rm -f app sidekiq
$DOCKER volume rm hacktoberfest_gem_cache
$COMPOSE -f $FILE -f $RESTART_FILE up -d --build --force-recreate --no-deps app sidekiq
 