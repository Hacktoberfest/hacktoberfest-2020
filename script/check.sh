#!/bin/sh

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
FILE="docker-compose.yml"

$COMPOSE -f $FILE ps 
