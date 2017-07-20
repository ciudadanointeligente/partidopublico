ch#!/bin/bash

echo "setting env vars for papulaunch"
echo "running as $(whoami)"

SECRET_KEY_BASE=1a0dedf26783f37253fc66b6d2cd833591148bda9d3d6807355180e5ca99a431531a15a4327f409293b0a08a41f078223967d59a318866d63755e65dac2ab673
POSTGRESQL_PORT=5432
POSTGRESQL_USER=papu
POSTGRESQL_PASSWORD=papu
RAILS_ENV=production
RAILS_PORT=3000

export SECRET_KEY_BASE
export POSTGRESQL_PORT
export POSTGRESQL_USER
export POSTGRESQL_PASSWORD
export RAILS_ENV
export RAILS_PORT

echo "starting papu"

# docker-compose down
docker-compose up -d

echo "papu started"
