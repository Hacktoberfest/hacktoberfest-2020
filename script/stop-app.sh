#!/bin/sh

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
FILE="docker-compose.yml"

$COMPOSE -f $FILE stop app && $COMPOSE -f $FILE rm app