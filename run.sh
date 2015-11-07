#!/usr/bin/env bash

# Database
cd database/
redis-server &

# Server
cd ../server/src
nodemon main.coffee &

# Client
cd ../../client
grunt serve