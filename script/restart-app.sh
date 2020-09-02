#!/bin/sh

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
FILE="docker-compose.yml"
RESTART_FILE="docker-compose.restart.yml"

$COMPOSE stop app && $COMPOSE rm -f app
$COMPOSE -f $FILE -f $RESTART_FILE up -d --no-deps app
