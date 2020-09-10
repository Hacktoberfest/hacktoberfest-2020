#!/bin/sh

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
DOCKER="/usr/local/bin/docker"

$COMPOSE down
$DOCKER system prune -a -f --volumes
