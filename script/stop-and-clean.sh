#!/bin/sh

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
FILE="docker-compose.yml"
DOCKER="/usr/local/bin/docker"

$COMPOSE -f $FILE down
$DOCKER system prune -a -f --volumes
